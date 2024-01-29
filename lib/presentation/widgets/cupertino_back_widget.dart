import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:red_bull_case_study/style/apptypography.dart';

class CupertinoBackWidget extends StatelessWidget {
  final String title;

  const CupertinoBackWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
          Text(
            title,
            style: RedBullTextStyles.blueAppbarText,
          )
        ],
      ),
      onTap: () => context.pop(),
    );
  }
}
