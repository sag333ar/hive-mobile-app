import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/controller/post_detail_controller.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/view/post_detail_post_web_view.dart';
import 'package:hive_mobile_app/feature/post/presentation/views/post_detail/widgets/post_detail_web_view/post_detail_web_info_widget.dart';
import 'package:provider/provider.dart';

class PostDetailMaxWebView extends StatelessWidget {
  const PostDetailMaxWebView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<PostDetailController>();
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: (width * 0.4).clamp(300, 600),
            child: PostDetailWebInfoWidget(
              data: controller.data,
            ),
          ),
          Expanded(
              child: PostDetailPostWebView(
                  width: width, body: controller.data.body))
        ],
      ),
    );
  }
}
