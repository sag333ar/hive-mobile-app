import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/core/utilities/theme/theme_mode.dart';
import 'package:provider/provider.dart';

class PostDetailPostWebView extends StatefulWidget {
  const PostDetailPostWebView(
      {super.key, required this.width, required this.body});

  final double width;
  final String body;

  @override
  State<PostDetailPostWebView> createState() => _PostDetailPostWebViewState();
}

class _PostDetailPostWebViewState extends State<PostDetailPostWebView> {
  String? htmlString;
  late final InAppWebViewController controller;

  @override
  void initState() {
    getHtmlAndLoad(widget.body, widget.width.toInt(),
        !context.read<ThemeController>().isLightTheme());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return htmlString != null
        ? InAppWebView(
            onScrollChanged: (controller, x, y) async {
              int? offset = await controller.getContentHeight();
              log(offset.toString());
              print("$x , $y");
            },
            onWebViewCreated: (controller) => this.controller = controller,
            initialData: InAppWebViewInitialData(data: htmlString!),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  void getHtmlAndLoad(String inputString, int width, bool isDarkMode) async {
    final String result = await ApiService().getHtml(
      inputString,
      width,
    );
    if (mounted) {
      String textColor = isDarkMode ? 'white' : 'black';
      htmlString = result.replaceAll("<img src",
          "<img style='display: block; margin: 0 auto;' width='100%' src");
      String fontSize = context.isMobileSize ? "30px" : "18px";
      String backgroundColor = isDarkMode ? 'black' : 'white';
      htmlString =
          "<body style='font-size: $fontSize; background-color: $backgroundColor; color: $textColor; padding: 20; font-family: Poppins' link='#FF5722'>$htmlString</body>";

      setState(() {});
    }
  }
}
