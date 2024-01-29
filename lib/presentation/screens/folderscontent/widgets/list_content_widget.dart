import 'package:flutter/material.dart';
import 'package:red_bull_case_study/blocs/foldercontent/folder_content_state.dart';
import 'package:red_bull_case_study/style/assets.dart';
import 'package:red_bull_case_study/style/colors.dart';
import 'package:red_bull_case_study/style/apptypography.dart';
import 'package:sizer/sizer.dart';

class ListContentWidget extends StatelessWidget {
  final List<Item> items;
  final bool isLoading;
  final VoidCallback onBottom;
  final ValueSetter<Item> onItemClick;

  const ListContentWidget({
    super.key,
    required this.items,
    required this.onBottom,
    required this.isLoading,
    required this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (scrollEnd) {
          final metrics = scrollEnd.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (!isTop) {
              onBottom();
            }
          }
          return true;
        },
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: RedBullColors.colorAccent,
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: items.length,
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: const Divider(),
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  return InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: ContentListItem(
                        creationDate: item.creationDate,
                        imageUrl: item.thumbnailUrl,
                        isPicture: item.isPicture,
                        duration:
                            item.duration == null ? 'N/A' : item.duration!,
                        title: item.name,
                      ),
                    ),
                    onTap: () => onItemClick(item),
                  );
                },
              ),
      ),
    );
  }
}

class ContentListItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;
  final String creationDate;
  final bool isPicture;

  const ContentListItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.isPicture,
    required this.duration,
    required this.creationDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 20.w,
                height: 10.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: RedBullTextStyles.normalBoldTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Duration: $duration',
                    style: RedBullTextStyles.smallTextStyle,
                  ),
                  Text(
                    'Created at: $creationDate',
                    style: RedBullTextStyles.smallTextStyle,
                  ),
                  Image.asset(
                    isPicture ? RedBullAssets.icImage : RedBullAssets.icVideo,
                    height: 2.h,
                  ),
                ],
              ),
            ),
            SizedBox(width: 3.w),
            Container(
              alignment: Alignment.centerRight,
              child: Image.asset(RedBullAssets.icPlay),
            ),
          ],
        ),
      ),
    );
  }
}
