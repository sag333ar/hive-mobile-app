import 'package:auth/core/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/dense_icon_button.dart';
import 'package:hive_mobile_app/core/common/widgets/images/user_profile_image.dart';
import 'package:hive_mobile_app/core/utilities/parser.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';
import 'package:hive_mobile_app/feature/inbox/models/inbox_detail_navigaiton_model.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/controller/inbox_controller.dart';
import 'package:hive_mobile_app/feature/inbox/presentation/replies/widgets/bookmark_icon.dart';
import 'package:hive_mobile_app/feature/post/models/post_feeds/post_feed_model.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class InboxItem extends StatelessWidget {
  const InboxItem(
      {super.key, required this.item, required this.selectedPostDetailView});

  final PostFeedModel item;
  final ValueNotifier<PostFeedModel?>? selectedPostDetailView;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<InboxController>();
    String body = Parser.parseAndFilterText(
      item.body,
    );
    var timeInString = timeago.format(item.created);
    return InkWell(
      onTap: () {
        if (context.isMobileSize) {
          context.pushNamed(Routes.inboxDetailView,
              extra: InboxDetailNavigaitonModel(
                  controller: controller, postFeedModel: item));
        } else {
          if (selectedPostDetailView != null) {
            selectedPostDetailView!.value = item;
          }
        }
      },
      child: Container(
        color: theme.colorScheme.tertiaryContainer,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kScreenHorizontalPaddingDigit, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UserProfileimage(
                        url: item.author,
                      ),
                      const Gap(15),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  item.author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "  •  $timeInString",
                                style: theme.textTheme.labelSmall!.copyWith(
                                    color: theme.primaryColorDark
                                        .withOpacity(0.7)),
                              )
                            ],
                          ),
                          const Gap(4),
                          Text(item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              )),
                          if (body.isNotEmpty)
                            Text(body,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 13,
                                    color:
                                        theme.primaryColorDark.withOpacity(0.9),
                                    fontWeight: FontWeight.w300)),
                        ],
                      )),
                      
                    ],
                  ),
                ],
              ),
            ),
            // Positioned(
            //   top: 0,
            //   bottom: 0,
            //   right: kScreenHorizontalPaddingDigit,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       BookmarkIcon(item: item),
            //       DenseIconButton(
            //         onPressed: () {
            //           controller.ignoreAuthor(item.author);
            //         },
            //         icon: Icons.block,
            //         color: Colors.red,
            //       ),
            //       DenseIconButton(
            //         onPressed: () {},
            //         icon: Icons.check,
            //         color: Colors.green,
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
