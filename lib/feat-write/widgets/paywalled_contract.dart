import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaywalledContract extends StatefulWidget {
  const PaywalledContract({super.key});

  @override
  State<PaywalledContract> createState() => _PaywalledContractState();
}

class _PaywalledContractState extends State<PaywalledContract> {
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    ScrollController? scrollController;

    @override
    void initState() {
      super.initState();
      scrollController = ScrollController();

      scrollController?.addListener(() {
        if (scrollController?.position.userScrollDirection ==
            ScrollDirection.forward) {
          print('for');
        }
        if (scrollController?.position.userScrollDirection ==
            ScrollDirection.reverse) {
          print('down');
        }
      });
    }

    @override
    void dispose() {
      scrollController?.dispose();
      super.dispose();
    }

    space() {
      return SizedBox(
        height: 16,
      );
    }

    title(index, content) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          '$index. $content',
          style: textTheme.headlineSmall?.copyWith(color: appColors.inkBase),
          textAlign: TextAlign.justify,
        ),
      );
    }

    subtitle(index, content) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          '$index. $content',
          style: textTheme.titleMedium?.copyWith(color: appColors.inkLighter),
          textAlign: TextAlign.justify,
        ),
      );
    }

    content(content) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          content,
          style: textTheme.titleMedium?.copyWith(color: appColors.inkLighter),
          textAlign: TextAlign.justify,
        ),
      );
    }

    return Container(
      height: size.height - 100,
      child: ListView(
        controller: scrollController,
        children: [
          space(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Audiory - Điều khoản và Điều kiện',
                  style: textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Cập nhật lần cuối: 10/03/2023',
                  style: textTheme.headlineSmall
                      ?.copyWith(color: appColors.inkLight),
                ),
              ],
            ),
          ),
          space(),
          title(1, 'Chấp nhận các điều khoản'),
          content(
              'Bằng cách sử dụng Audiory ("Ứng dụng") và chấp nhận các điều khoản và điều kiện này ("Thỏa thuận"), bạn ("Tác giả") đồng ý tuân thủ và bị ràng buộc bởi các điều khoản và điều kiện trong tài liệu này. Nếu bạn không đồng ý với bất kỳ phần nào của Thỏa thuận này, vui lòng không sử dụng Ứng dụng.'),
          space(),
          title(2, 'Thỏa thuận cấp phép'),
          content(
              'Bằng cách chấp nhận Thỏa thuận này, Tác giả cấp cho Audiory ("Công ty") giấy phép không độc quyền, trên toàn thế giới, miễn phí bản quyền để lưu trữ, hiển thị, phân phối và bán các tác phẩm văn học của Tác giả, bao gồm các câu chuyện, bản âm thanh, và nội dung văn bản khác ("Nội dung") trên Ứng dụng trong thời hạn mười (10) năm kể từ ngày chấp nhận.'),
          space(),
          title(3, 'Quyền sở hữu và bản quyền'),
          subtitle(3.1,
              'Tác giả giữ mọi quyền sở hữu và bản quyền đối với Nội dung được cung cấp cho Ứng dụng. Giấy phép được cấp ở đây không chuyển quyền sở hữu Nội dung cho Công ty.'),
          subtitle(3.2,
              'Tác giả có thể chọn xóa Nội dung của họ khỏi Ứng dụng sau khi hết thời hạn cấp phép 10 năm.'),
          space(),
          title(4, 'Thù lao'),
          subtitle(4.1,
              'Tác giả sẽ nhận được thù lao bằng kim cương cho các chương do độc giả mua, với mức hoa hồng được khấu trừ theo cấp độ của tác giả như sau:'),
          content('Tập sự: Hoa hồng 20%'),
          content('Ngôi sao mới nổi: Hoa hồng 40%'),
          content('Tác giả nổi tiếng: Hoa hồng 50%'),
          subtitle(4.2,
              'Ngoài ra, tác giả sẽ nhận được khoản thù lao dưới dạng kim cương cho những món quà nhận được từ độc giả, tuân theo tỷ lệ hoa hồng quà tặng sau đây dựa trên cấp độ của tác giả:'),
          content('Tập sự: Hoa hồng quà tặng 50%'),
          content('Ngôi sao mới nổi: Hoa hồng quà tặng 60%'),
          content('Tác giả nổi tiếng: Hoa hồng quà tặng 70%'),
          subtitle(4.3,
              'Khi tác giả chọn đặt một truyện thành trả phí, các chương được đăng sau khi áp dụng quyết định này mới có lệ phí, trong khi các chương đã đăng trước đó sẽ vẫn được truy cập miễn phí.'),
          subtitle(4.4,
              'Khi tác giả mới đặt truyện thành trả phí, số kim cương kiếm được từ các chương được mua trong 30 ngày đầu tiên sẽ được đặt trong thời gian đóng băng tạm thời. Điều này được thực hiện để đảm bảo tác giả là người dùng tuân thủ Nguyên tắc Nội dung và Nguyên tắc Cộng đồng của Ứng dụng. Sau thời gian đóng băng 30 ngày đầu tiên, kim cương kiếm được sẽ không còn bị đóng băng nữa và sẽ được chi trả cho tác giả.'),
          subtitle(4.5,
              'Tác giả có thể chọn chuyển số kim cương kiếm được của mình thành tiền thật. Tỷ lệ chuyển đổi từ kim cương sang tiền thật sẽ được xác định theo chính sách và hướng dẫn của Ứng dụng, với giới hạn rút là tối đa 20.000 viên kim cương mỗi tháng.'),
          space(),
          title(5, 'Quyền riêng tư'),
          content(
              'Tác giả đồng ý với Chính sách quyền riêng tư của Ứng dụng, trong đó nêu rõ cách thu thập, sử dụng và bảo vệ dữ liệu cá nhân. Thông tin cá nhân của tác giả sẽ chỉ được sử dụng cho các mục đích được nêu trong Chính sách quyền riêng tư.'),
          space(),
          title(6, ' Bồi thường'),
          content(
              'Tác giả đồng ý bồi thường và giữ cho Công ty không bị tổn hại trước mọi khiếu nại, tổn thất hoặc trách nhiệm pháp lý phát sinh từ việc xuất bản Nội dung trên Ứng dụng, bao gồm mọi hành vi vi phạm bản quyền.'),
          space(),
          title(7, 'Thay đổi Điều khoản'),
          content(
              'Công ty có quyền sửa đổi các điều khoản và điều kiện này bất cứ lúc nào. Tác giả sẽ được thông báo về bất kỳ thay đổi nào và việc tiếp tục sử dụng Ứng dụng sau khi thông báo đó đồng nghĩa với việc chấp nhận các điều khoản đã sửa đổi.'),
          space(),
          title(8, ' Thông tin liên hệ'),
          content(
              'Nếu bạn có bất kỳ câu hỏi hoặc thắc mắc nào về các điều khoản và điều kiện này, vui lòng liên hệ với chúng tôi theo địa chỉ audiory@gmail.com.'),
          content(
              'Bằng cách chấp nhận các điều khoản và điều kiện này, bạn thừa nhận rằng bạn đã đọc, hiểu và đồng ý bị ràng buộc bởi chúng.'),
          space(),
          space(),
        ],
      ),
    );
  }
}
