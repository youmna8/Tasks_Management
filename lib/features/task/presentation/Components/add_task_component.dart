
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskComponent extends StatelessWidget {
  AddTaskComponent(
      {super.key,
      required this.title,
      this.controller,
      required this.hintTxt,
      this.sffixIcon, 
       this.readOnly=false, this.validator});
  final String title;
  final TextEditingController? controller;
  final String hintTxt;
  final IconButton? sffixIcon;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(hintText: hintTxt, suffixIcon: sffixIcon),
          validator: validator ,
        ),
      ],
    );
  }
}
