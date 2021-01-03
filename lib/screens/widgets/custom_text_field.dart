import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/utilities/theme.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final double fontSize;
  final FontWeight fontWeight;
  final Function(String val) onChanged;
  final double height;
  final void Function(String) onSubmitted;
  final TextInputAction inputAction;
  CustomTextField({
    this.hint,
    this.fontSize,
    this.fontWeight,
    this.onChanged,
    this.height = 54.0,
    this.onSubmitted,
    this.inputAction,
    
  });

  final _border = const OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: height,
      child: TextField(
        
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        textInputAction: inputAction,
        cursorColor: Colors.black,
        style: Theme.of(context).textTheme.overline.copyWith(
              color: Colors.black,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
          enabledBorder: _border,
          border: _border,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color:
                  themeProvider.isLightTheme ? Colors.white : Color(0xFF26242e),
              width: 2.0,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color:
                themeProvider.isLightTheme ? Colors.white : Color(0xFF26242e),
            blurRadius: 0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
    );
  }
}
