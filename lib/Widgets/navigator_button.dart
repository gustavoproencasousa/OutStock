import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  final Widget page;
  final String text;
  final Widget? icon;
  const NavigatorButton({super.key, required this.page, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return page;
            }));
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.maxFinite, 0),
              padding: const EdgeInsets.all(16)),
          child: Row(
            children: [icon??const SizedBox(),const SizedBox(width: 4,),Expanded(child: Text(text)), const Icon(Icons.forward)],
          )),
    );
  }
}
