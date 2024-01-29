import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:red_bull_case_study/blocs/folders/folders_cubit.dart';
import 'package:red_bull_case_study/presentation/widgets/cupertino_back_widget.dart';
import 'package:red_bull_case_study/style/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FoldersCubit>(context);
    final strings = AppLocalizations.of(context)!;

    return BlocBuilder<FoldersCubit, List<String>>(builder: (context, state) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 3.h),
                  CupertinoBackWidget(
                    title: strings.content_manager,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    strings.project_folders,
                    style: RedBullTextStyles.titleTextStyle,
                  ),
                  SizedBox(height: 2.h),
                  CupertinoSearchTextField(
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    suffixIcon: const Icon(
                      Icons.clear,
                    ),
                    onChanged: cubit.searchFolder,
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: const Divider(),
                        );
                      },
                      itemCount: state.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: ListTile(
                            leading: ImageIcon(
                              const AssetImage(RedBullAssets.icFolder),
                              size: 9.w,
                              color: RedBullColors.colorLightBlue,
                            ),
                            title: Text(state[index],
                                style: RedBullTextStyles.normalTextStyle),
                            onTap: () {
                              context.push('/folder_content/${state[index]}');
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      RedBullAssets.icRedBull,
                      height: 15.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
