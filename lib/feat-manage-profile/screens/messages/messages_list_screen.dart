import 'package:audiory_v0/feat-manage-profile/screens/messages/detail_conversation_screen.dart';
import 'package:audiory_v0/models/conversation/conversation_model.dart';
import 'package:audiory_v0/repositories/conversation_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MessagesListScreen extends StatefulHookWidget {
  final String userId;
  const MessagesListScreen({super.key, required this.userId});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  Widget newMessageBadge(Color color, double? size, {bool? isOnline = false}) {
    return Container(
      width: size ?? 20,
      height: size ?? 20,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: isOnline == true
                  ? Theme.of(context).extension<AppColors>()!.skyLightest
                  : color,
              width: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final conversationsQuery = useQuery(
        ['conversations'],
        refetchOnMount: RefetchOnMount.always,
        () => ConversationRepository().fetchAllConversations());
    final searchValue = useState('');
    final foundContacts = useState([]);
    String formatDate(String? date) {
      //use package intl

      DateTime dateTime = DateTime.parse(date ?? DateTime.now().toString());
      return DateFormat('HH:mm').format(dateTime);
    }

    useEffect(() {
      conversationsQuery.refetch();
    }, []);

    Widget conversationsList(List<Conversation> list) {
      // if (searchValue.value != '') {
      //   print('SORT');
      //   list.where((element) =>
      //       element.name?.toLowerCase() == searchValue.value.toLowerCase());
      // } else {}
      // print('list ${list.length}');
      Widget conversationCard(Conversation conversation, bool isRead) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: AppAvatarImage(
                size: 65,
                url: conversation.coverUrl ?? '',
              ),
            ),
            Flexible(
                flex: 7,
                child: SizedBox(
                  height: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${conversation.name == '' ? 'Người dùng' : conversation.name}',
                        style: textTheme.headlineSmall
                            ?.copyWith(color: appColors.inkBase),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              flex: 3,
                              child: Text(
                                '${conversation.lastMessage?.content}  ',
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleLarge?.copyWith(
                                    color: isRead
                                        ? appColors.inkLighter
                                        : appColors.inkBase),
                              )),
                          Flexible(
                              child: Text(
                            formatDate(conversation.lastActive),
                            style: textTheme.bodyMedium?.copyWith(
                                color: isRead
                                    ? appColors.inkLighter
                                    : appColors.inkLighter),
                          )),
                        ],
                      )
                    ],
                  ),
                )),
            Flexible(
              flex: 1,
              child: isRead
                  ? newMessageBadge(Colors.transparent, 12)
                  : newMessageBadge(Colors.blue[300] as Color, 12),
            ),
          ],
        );
      }

      return list.length == 0
          ? Text('Chưa có cuộc hội thoại nào')
          : Column(
              children: list.asMap().entries.map((e) {
                Conversation? conversation = e.value;
                return GestureDetector(
                  onTap: () {
                    // context.push('/profileSettings/messages/detailMessage',
                    //     extra: {
                    //       'conversation': conversation,
                    //       'userId': widget.userId
                    //     });

                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (context) {
                          return SafeArea(
                            child: DetailConversationScreen(
                              conversation: conversation,
                              userId: widget.userId,
                              refetchCallback: () {
                                print('vall');
                                conversationsQuery.refetch();
                              },
                            ),
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: conversationCard(conversation,
                        conversation.isLatestMessageRead ?? false),
                  ),
                );
              }).toList(),
            );
    }

    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        title: Text(
          'Tin nhắn',
          style: textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(children: [
          FormBuilder(
              child: AppTextInputField(
            onChangeCallback: (value) {
              searchValue.value = value;
            },
            name: 'search',
            backgroundColor: appColors.skyLighter.withOpacity(0.7),
            hintText: 'Tìm kiếm',
            suffixIcon: Icon(
              Icons.search,
              color: appColors.inkLight,
            ),
          )),
          const SizedBox(
            height: 24,
          ),
          Skeletonizer(
            enabled: conversationsQuery.isFetching,
            child: conversationsList(conversationsQuery.data ?? []),
          ),
        ]),
      )),
    );
  }

  void searchContacts(value) {}
}
