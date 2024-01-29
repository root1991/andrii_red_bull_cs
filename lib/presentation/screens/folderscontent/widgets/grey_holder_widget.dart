import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GreyHolderWidget extends StatelessWidget {
  const GreyHolderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          height: 0.5.h,
          width: 10.w),
    );
  }
}