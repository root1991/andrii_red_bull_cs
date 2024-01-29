import 'package:flutter/material.dart';
import 'package:red_bull_case_study/presentation/widgets/cupertino_back_widget.dart';
import 'package:red_bull_case_study/style/assets.dart';
import 'package:sizer/sizer.dart';

class CustomCupertinoAppBar extends StatelessWidget {
  final String title;

  const CustomCupertinoAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 2.h,
        top: 2.h,
        left: 3.5.w,
        right: 5.w,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: CupertinoBackWidget(title: 'Projects')
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              RedBullAssets.icFilter,
            ),
          ),
        ],
      ),
    );
  }
}
