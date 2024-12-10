import 'package:flutter/material.dart';

import 'package:movies_app/support/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.hint,
    this.isObscured = false,
    this.iconData,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor,
    this.readOnly = false,
    this.validation,
    this.onTap,
    this.maxLines,
    this.prefixIcon,
    this.borderBackgroundColor,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderBackgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;
  final void Function()? onTap;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color: widget.backgroundColor ?? AppColors.grayColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: widget.borderBackgroundColor ??
                      AppColors.transparentColor)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(
            style: TextStyle(color: AppColors.whiteColor),
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: widget.cursorColor ?? AppColors.whiteColor,
            onTap: widget.onTap,
            onEditingComplete: () {
              widget.focusNode?.unfocus();
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction: widget.nextFocus == null
                ? TextInputAction.done
                : TextInputAction.next,
            validator: (value) {
              if (widget.validation == null) {
                setState(() {
                  errorText = null;
                });
              } else {
                setState(() {
                  errorText = widget.validation!(value);
                });
              }
              return errorText;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              hintText: widget.hint,
              hintStyle: TextStyle(color: AppColors.whiteColor),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscured
                  ? IconButton(
                      onPressed: () {
                        setState(
                          () {
                            hidden = !hidden;
                          },
                        );
                      },
                      iconSize: 24,
                      splashRadius: 1,
                      isSelected: !hidden,
                      color: AppColors.whiteColor,
                      selectedIcon: const Icon(Icons.visibility),
                      icon: const Icon(Icons.visibility_off_sharp),
                    )
                  : widget.suffixIcon,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorStyle: TextStyle(
                fontSize: 18,
                color: AppColors.redColor,
              ),
            ),
          ),
        ),
        errorText == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 8,
                ),
                child: Text(
                  errorText!,
                ),
              ),
      ],
    );
  }
}
