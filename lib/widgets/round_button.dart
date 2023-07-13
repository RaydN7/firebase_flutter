import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
//components are reusable
  final String title;
  final VoidCallback
      onTap; // "final" is used to declare a constant or an immutable value.'VoidCallBack' represents a function or method that doesn't return any value (void) when it is called.
  final bool loading; //to show loading
  const RoundButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              // Login box and 'Login' button color
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  ),
          )),
    );
  }
}
