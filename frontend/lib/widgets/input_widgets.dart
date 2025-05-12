import 'package:flutter/material.dart';
import 'package:frontend/providers/utils.dart';

class InputWidget extends StatefulWidget {
  final Function(String)? onChanged;
  final String hintText;
  final bool isPassword;
  final String? initialValue;
  final Widget? prefixIcon;

  const InputWidget(
      {super.key,
      required this.hintText,
      this.isPassword = false,
      this.onChanged,
      this.initialValue,
      this.prefixIcon});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool isPressed = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      width: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            onChanged: widget.onChanged,
            initialValue: widget.initialValue,
            obscureText: widget.isPassword && !isPressed,
            enableSuggestions: !widget.isPassword,
            autocorrect: false,
            style: TextStyle(color: Utils.textColor, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
              filled: true,
              fillColor: Utils.foregroundColor,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Utils.inactiveColor),
              labelStyle: TextStyle(color: Utils.inactiveColor),
              labelText: widget.hintText,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          if (widget.isPassword)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => setState(() => isPressed = !isPressed),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    isPressed ? Icons.visibility_off : Icons.visibility,
                    color: Utils.textColor,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  final Function()? onPressed;
  final String text;
  final bool buttonActive;
  final double width;
  final Color? backgroundColor;

  const ButtonWidget(
      {super.key,
      required this.text,
      this.buttonActive = true,
      this.width = 300,
      this.onPressed,
      this.backgroundColor});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 40,
      child: ElevatedButton(
          onPressed: widget.buttonActive ? widget.onPressed : null,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  widget.backgroundColor ?? Utils.backgroundColor)),
          child: Text(
            widget.text,
            style: TextStyle(fontSize: 16, color: Utils.textColor),
          )),
    );
  }
}
