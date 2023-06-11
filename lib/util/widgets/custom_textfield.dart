import 'package:aklo_cafe/constant/resources.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool require;
  final bool? enable;
  final bool? obscureText;
  final int? maxLines;
  final EdgeInsets? padding;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.label,
    this.require = false,
    this.padding,
    this.obscureText,
    this.textInputType,
    this.textInputAction,
    this.suffixIcon,
    this.validator,
    this.controller,
    this.enable,
    this.onTap,
    this.onFieldSubmitted,
    this.maxLines,
  });

  OutlineInputBorder get _border =>
      const OutlineInputBorder(borderRadius: BorderRadius.zero);
  OutlineInputBorder get _errorBorder => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.zero);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: Sizes.defaultPadding),
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          obscureText: obscureText ?? false,
          enabled: enable,
          controller: controller,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          maxLines: maxLines,
          style: AppStyle.medium.copyWith(
            letterSpacing: 0.6,
          ),
          onTapOutside: (_) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelStyle: AppStyle.medium,
            // hintStyle: AppStyle.medium,
            errorStyle: AppStyle.small.copyWith(
                color: Colors.red, fontSize: 12, fontWeight: Sizes.wM),
            label: RichText(
              text: TextSpan(
                text: label,
                style: AppStyle.medium,
                children: [
                  if (require)
                    WidgetSpan(
                      alignment: PlaceholderAlignment.top,
                      child: Text(
                        ' *',
                        style: AppStyle.small
                            .copyWith(color: Colors.red, fontWeight: Sizes.wM),
                      ),
                    ),
                ],
              ),
            ),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            disabledBorder: _border,
            enabledBorder: _border,
            focusedBorder: _border,
            errorBorder: _errorBorder,
            focusedErrorBorder: _errorBorder,
            isDense: true,
            suffixIcon: suffixIcon,
            suffixIconColor: AppColors.txtDarkColor,
          ),
        ),
      ),
    );
  }
}
