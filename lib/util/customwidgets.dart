import 'package:doctor_appointment_app/util/appthem.dart';
import 'package:flutter/material.dart';

class CustomWidget {
  // static Color primary = const Color(0xff11463C);
  // static Color secondry = const Color(0xffFAC783);
  static Color primary = Colors.white;
  static Color secondry = const Color(0xff11463C);
  static Widget largeText(
    String? text, {
    var fontSize = 18.0,
    height = 1.5,
    Color? textColor,
    var fontFamily,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
  }) {
    return Text(
      textAllCaps ? text!.toUpperCase() : text!,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor ?? Apptheme.primary,
        height: height,
        letterSpacing: latterSpacing,
        decoration:
            lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  static Widget heading(
    String? text, {
    var fontSize = 16.0,
    double height = 25,
    double width = 100,
    Color? textColor,
    var fontFamily,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
  }) {
    return Container(
      height: height,
      width: width,
      child: Text(
        textAllCaps ? text!.toUpperCase() : text!,
        textAlign: isCentered ? TextAlign.center : TextAlign.start,
        maxLines: isLongText ? null : maxLine,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor ?? Apptheme.primary,
          height: 1.5,
          letterSpacing: latterSpacing,
          decoration:
              lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
    );
  }

  static Widget smalltext(
    String? text, {
    var fontSize = 12.0,
    Color? textColor,
    var fontFamily,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
  }) {
    return Text(
      textAllCaps ? text!.toUpperCase() : text!,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor ?? Apptheme.primary,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration:
            lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }

  static BoxDecoration boxDecoration(
      {double radius = 2,
      Color color = Colors.transparent,
      Color? bgColor,
      var showShadow = false}) {
    return BoxDecoration(
      color: bgColor ?? Colors.grey[300],
      boxShadow: showShadow
          ? [BoxShadow(color: bgColor!)]
          : [const BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  static Container smallcontainer(
      {double radius = 2,
      bordercolor,
      Color color = Colors.transparent,
      Color? bgColor,
      Widget? child,
      var showShadow = false,
      height,
      width}) {
    return Container(
      height: height ?? height * 0.025,
      width: width ?? width * 0.02,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.grey[200],
        boxShadow: showShadow
            ? [BoxShadow(color: bgColor!)]
            : [const BoxShadow(color: Colors.transparent)],
        border: Border.all(color: bordercolor ?? Colors.grey[200]),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: child,
    );
  }

  static SizedBox textformfield({
    required double width,
    required double height,
    Function(String)? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    TextEditingController? controller,
    String? hinttext,
    Widget? prefixIcon,
    bool isWeb = false,
    bool isPassword = false,
    bool obscureText = false,
    String? labelText,
    bool showBorder = true,
    double borderRadius = 50.0,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? fillColor,
    Color? labelColor,
    TextStyle? labelStyle,
    Color? hintTextColor,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    String? initialValue,
    int? maxLength,
    bool enabled = true,
    bool readOnly = false,
    bool autocorrect = true,
    bool enableSuggestions = true,
    TextInputAction textInputAction = TextInputAction.done,
    Function(String?)? onSaved,
    FocusNode? focusNode,
    int? maxLines,
    int? minLines,
    TextCapitalization textCapitalization = TextCapitalization.none,
    AutovalidateMode? autovalidateMode,
    Key? key,
  }) {
    return SizedBox(
      width: width * 0.8,
      height: height * 0.1,
      child: Center(
        child: TextFormField(
          key: key,
          initialValue: initialValue,
          autovalidateMode:
              autovalidateMode ?? AutovalidateMode.onUserInteraction,
          controller: controller,
          autofocus: false,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          obscureText: obscureText && isPassword,
          validator: validator,
          maxLength: maxLength,
          enabled: enabled,
          readOnly: readOnly,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          textInputAction: textInputAction,
          onSaved: onSaved,
          focusNode: focusNode,
          maxLines: maxLines,
          minLines: minLines,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.black45,
                      width: 1.5,
                    ),
                  )
                : InputBorder.none,
            filled: true,
            fillColor: fillColor ?? Colors.grey.withOpacity(0.15),
            labelText: labelText ?? hinttext ?? 'Title',
            labelStyle: labelStyle ??
                TextStyle(
                  color: labelColor ?? Colors.black,
                  fontSize: isWeb ? width * 0.01 : width * 0.03,
                  fontWeight: FontWeight.w500,
                ),
            hintText: hinttext ?? 'Title',
            hintStyle: TextStyle(
              color: hintTextColor ?? Colors.grey,
              fontSize: isWeb ? width * 0.01 : width * 0.03,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(top: 15, left: width * 0.02),
              child: prefixIcon,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: focusedBorderColor ?? Colors.blue,
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: errorBorderColor ?? Colors.red,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
