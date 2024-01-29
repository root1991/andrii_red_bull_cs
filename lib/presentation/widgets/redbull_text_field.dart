import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_bull_case_study/presentation/widgets/redbull_text_field_cubit.dart';
import 'package:red_bull_case_study/style/colors.dart';
import 'package:red_bull_case_study/style/apptypography.dart';

// ignore: must_be_immutable
class RedBullTextField extends StatelessWidget {
  final String labelText;
  final String preffixIcon;
  final TextEditingController controller;
  String? suffixIcon;

  RedBullTextField({
    super.key,
    required this.labelText,
    required this.preffixIcon,
    this.suffixIcon, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RedBullTextFieldCubit, bool>(
      builder: (context, isObscured) {
        return Material(
          elevation: 1,
          shadowColor: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.0),
          child: TextField(
            controller: controller,
            style: RedBullTextStyles.labelTextStyle.copyWith(
              color: Colors.black,
            ),
            obscureText: suffixIcon != null && isObscured,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: RedBullTextStyles.labelTextStyle,
              border: InputBorder.none,
              prefixIcon: ImageIcon(
                AssetImage(preffixIcon),
                color: Colors.black,
              ),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      icon: isObscured
                          ? ImageIcon(
                              AssetImage(suffixIcon!),
                              color: RedBullColors.colorGrey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: RedBullColors.colorGrey,
                            ),
                      onPressed: () =>
                          context.read<RedBullTextFieldCubit>().toggle(),
                    )
                  : const SizedBox(),
            ),
          ),
        );
      },
    );
  }
}
