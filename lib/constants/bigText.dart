import 'package:flutter/material.dart';
import 'package:hive_database/constants/colors.dart';

class Bigtext extends StatelessWidget {
  String title;
  final Color? color;

  Bigtext({required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.blackColor,
      ),
    );
  }
}
