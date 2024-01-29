import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:red_bull_case_study/blocs/foldercontent/folder_content.dart';
import 'package:red_bull_case_study/presentation/widgets/cupertino_back_widget.dart';
import 'package:red_bull_case_study/style/styles.dart';
import 'package:sizer/sizer.dart';

import 'widgets/folders_content.widgets.dart';

class FolderContentScreen extends StatelessWidget {
  final String folderName;

  const FolderContentScreen({super.key, required this.folderName});
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FolderContentBloc>(context);
    return BlocConsumer<FolderContentBloc, FolderContentState>(
      listener: _blocListener,
        builder: (context, state) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: RedBullColors.colorAccent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: RedBullColors.colorAccent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 7.h,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      const GreyHolderWidget(),
                      CustomCupertinoAppBar(
                        title: folderName,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: 4.w, left: 4.w, bottom: 3.h),
                        child: CupertinoSearchTextField(
                          onChanged: (value) {
                            bloc.add(
                              SearchEvent(value, folderName),
                            );
                          },
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          suffixIcon: const Icon(
                            Icons.clear,
                          ),
                        ),
                      ),
                      ListContentWidget(
                        items: state.items,
                        isLoading: state.isLoading,
                        onBottom: () {
                          if (!state.isSearching) {
                            bloc.add(NextPageEvent(folderName));
                          }
                        },
                        onItemClick: (item) => _showBottomSheet(context, item),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: state.isPaginating
                            ? SizedBox(
                                height: 15.h,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: RedBullColors.colorAccent,
                                  ),
                                ),
                              )
                            : Image.asset(
                                RedBullAssets.icRedBull,
                                height: 15.h,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _blocListener(
    BuildContext context,
    FolderContentState state,
  ) {
    if (state.errorMessage != null) {
      showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(state.errorMessage!),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              context.pop();
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
    }
  }

  void _showBottomSheet(BuildContext context, Item item) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        builder: (context) {
          return SizedBox(
            height: 90.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 1.h,
                ),
                const GreyHolderWidget(),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, left: 2.w),
                  child: CupertinoBackWidget(
                    title: folderName,
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    item.name,
                    style: RedBullTextStyles.titleTextStyle,
                  ),
                ),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.thumbnailUrl,
                      height: 30.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Duration: ${item.duration ?? 'N/A'}',
                      style: RedBullTextStyles.smallTextStyle,
                    ),
                    Text(
                      'Created at: ${item.creationDate}',
                      style: RedBullTextStyles.smallTextStyle,
                    ),
                    Image.asset(
                      item.isPicture ? RedBullAssets.icImage : RedBullAssets.icVideo,
                      height: 2.h,
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
