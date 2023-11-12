import 'dart:convert';
import 'dart:typed_data';

import 'package:audiory_v0/feat-manage-profile/screens/messages/detail_message_bottom_bar.dart';
import 'package:audiory_v0/models/conversation/conversation_model.dart';
import 'package:audiory_v0/models/message/message_model.dart';
import 'package:audiory_v0/repositories/conversation_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fquery/fquery.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DetailConversationScreen extends StatefulHookWidget {
  final Conversation? conversation;
  final String? userId;
  final Function? refetchCallBack;

  const DetailConversationScreen({
    super.key,
    required this.conversation,
    this.userId = '',
    this.refetchCallBack,
  });

  @override
  State<DetailConversationScreen> createState() =>
      _DetailConversationScreenState();
}

class _DetailConversationScreenState extends State<DetailConversationScreen> {
  var storage = const FlutterSecureStorage();
  Uri wsUri = Uri.parse('');
  String senderId = '';
  List<Message> messages = [];
  List<Message> infiniteList = [];
  WebSocketChannel? channel;

  final ScrollController _controller = ScrollController();
  int pageNumber = 1;

// This is what you're looking for!
  void _scrollDown() {
    _controller.jumpTo(
      _controller.position.maxScrollExtent,
      // duration: Duration(seconds: 2),
      // curve: Curves.fastOutSlowIn,
    );
  }

  String formatDate(String? date) {
    //use package intl
    if (date == '') {
      date = DateTime.now().toString();
    }
    DateTime dateTime = DateTime.parse(date as String);
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  initState() {
    super.initState();
    connectWebsocket();
    try {
      _controller.addListener(() {
        print('listen');
        scollListener();
      });
    } catch (e) {
      print('ERR $e');
    }

    fetchMessages(pageNumber);
  }

  @override
  void dispose() {
    print('DISCONNECT');
    channel?.sink.close();
    super.dispose();
  }

  connectWebsocket() async {
    final jwtToken = await storage.read(key: 'jwt');
    wsUri = Uri.parse(
        'ws://${dotenv.get('HOST')}/messages/${widget.userId}?token=$jwtToken');

    channel = WebSocketChannel.connect(wsUri);
  }

  void _sendMessage(String content, List<Message> query) {
    if (messages.length == 0) {
      setState(() {
        messages.addAll(query);
      });
    }

    print('ID ${widget.conversation?.id}');

    Map<String, dynamic> message = {
      'receiver_id': widget.conversation?.receiverId ?? '',
      'conversation_id': widget.conversation?.id,
      'content': content,
      'sender_id': widget.userId
    };
    var actualBody = jsonEncode(message);
    setState(() {
      messages.insert(0, Message.fromJson(message));
    });
    channel?.sink.add(actualBody);
  }

  Future<void> fetchMessages(int offset) async {
    try {
      final newItems = await ConversationRepository()
          .fetchMessagesByConversationId(
              conversationId: widget.conversation?.id,
              limit: 10,
              offset: offset);
      setState(() {
        messages.addAll(newItems!.toList());
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final conversationQuery = useQuery(
        ['conversation'],
        () => ConversationRepository().fetchConversationById(
            conversationId: widget.conversation?.id, offset: 1, limit: 10));

    Widget messageCard({String? content = '', bool? isMe = true, date}) {
      Radius borderRadius = const Radius.circular(16);
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMe == true ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe == true
              ? const SizedBox(
                  height: 0,
                )
              : const Flexible(
                  child: AppAvatarImage(
                  size: 40,
                )),
          Container(
            margin: const EdgeInsets.only(left: 16),
            constraints:
                BoxConstraints(minWidth: 10, maxWidth: size.width - 120),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: borderRadius,
                  topRight: borderRadius,
                  bottomLeft:
                      isMe == true ? borderRadius : const Radius.circular(0),
                  bottomRight:
                      isMe == true ? const Radius.circular(0) : borderRadius,
                ),
                color: isMe == true
                    ? appColors.primaryBase
                    : appColors.skyLighter),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  content ?? '',
                  textAlign: TextAlign.justify,
                  style: textTheme.bodyMedium?.copyWith(
                      color: isMe == true
                          ? appColors.skyLightest
                          : appColors.inkBase),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  date ?? '',
                  textAlign: TextAlign.end,
                  style: textTheme.bodySmall?.copyWith(
                      color: isMe == true
                          ? appColors.skyLightest.withOpacity(0.8)
                          : appColors.inkBase.withOpacity(0.8)),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget getMessageList() {
      return Flexible(
        // decoration: BoxDecoration(color: appColors.backgroundDark),
        child: ListView.builder(
          controller: _controller,
          reverse: true,
          itemCount: messages.length == 0
              ? conversationQuery.data?.messages?.length ?? 0
              : messages.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 10),
          itemBuilder: (context, index) {
            Message? messageItem = messages.length == 0
                ? conversationQuery.data?.messages![index]
                : messages[index];
            String messageContent = messageItem?.content ?? '';
            bool isMe = messageItem?.senderId == widget.userId;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
              child: messageCard(
                  content: messageContent,
                  isMe: isMe,
                  date: formatDate(messageItem?.createdDate)),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: AppAvatarImage(
                    url: widget.conversation?.coverUrl ?? '',
                    size: 40,
                  ),
                )),
            Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.conversation?.name != null
                        ? widget.conversation?.name == ''
                            ? 'Người dùng'
                            : widget.conversation?.name as String
                        : 'Người dùng',
                    style: textTheme.titleLarge
                        ?.copyWith(color: appColors.inkBase),
                  ),
                  Text(
                    'Đang hoạt động ',
                    style: textTheme.bodySmall
                        ?.copyWith(color: appColors.inkLighter),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: channel?.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var decodedJson = utf8.decode(snapshot.data);
                    print('SNAPSHOT DATA ${decodedJson}');
                    print('LIST');
                    print('${messages.length}');

                    print('MESSAGE LIST $messages');
                    messages.insert(
                        0, Message.fromJson(jsonDecode(decodedJson)));
                    widget.refetchCallBack;
                  } else {
                    print('SNAPSHOT ERROR');
                    print('${snapshot.error}');
                  }

                  return getMessageList();
                },
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: DetailMessageBottomBar(sendMessageCallback: (content) {
            _sendMessage(content, conversationQuery.data?.messages ?? []);
          }),
        )
      ]),
    );
  }

  void scollListener() {
    print('compare ${_controller.position.pixels}');
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      //because listview is reverse
      print('call');
      pageNumber += 1;
      fetchMessages(pageNumber);
    } else {
      print('dont call');
    }
  }
}
