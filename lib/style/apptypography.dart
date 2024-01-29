import 'package:flutter/material.dart';
import 'package:red_bull_case_study/style/colors.dart';
import 'package:sizer/sizer.dart';

class RedBullTextStyles {
  static TextStyle labelTextStyle = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'SFPro',
    fontWeight: FontWeight.w700,
    color: RedBullColors.colorGrey,
  );
  static TextStyle titleTextStyle = labelTextStyle.copyWith(
    color: Colors.black,
    fontSize: 24.sp,
  );
  static TextStyle normalTextStyle = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'SFPro',
    color: RedBullColors.colorText,
  );
  static TextStyle normalBoldTextStyle = normalTextStyle.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  ); 
  static TextStyle smallTextStyle = normalTextStyle.copyWith(
    fontSize: 10.sp,
  );
  static TextStyle blueAppbarText = normalTextStyle.copyWith(
    color: RedBullColors.colorBlue,
  );
}
