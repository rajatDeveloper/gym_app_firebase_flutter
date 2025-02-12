import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  CustomElevatedBtn({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    this.fontSize,
    this.prefixIcon, // New parameter for icon
  }) : super(key: key);

  final IconData? prefixIcon; // IconData parameter for the prefix icon
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final String text;
  final VoidCallback onPressed;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: borderColor),
          elevation: 3,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 7.0,
          ),
          minimumSize: const Size.fromHeight(30),
        ),
        // Set the prefix icon
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)
              Icon(prefixIcon,
                  color: textColor), // Add the prefix icon if provided
            SizedBox(width: 8), // Add spacing between the icon and text
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
