import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  const RoundButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.margin});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  bool onLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin??const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      child: onLoading
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: onLoading
                  ? null
                  : widget.onPressed==null? null:() async {
                      setState(() => onLoading = true);
                      try {
                        await widget.onPressed!();
                      } catch (e) {
                        debugPrint('Error: $e');
                      } finally {
                        setState(() => onLoading = false);
                      }
                    },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: const EdgeInsets.all(16),
                  minimumSize: const Size(double.maxFinite, 0),
                  backgroundColor: widget.backgroundColor),
              child: Text(widget.text),
            ),
    );
  }
}
