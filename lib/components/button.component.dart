import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';

class AppButton extends StatelessWidget {
  final bool pressed;
  final String title;
  final Function()? onPress;
  const AppButton({super.key, required this.pressed, this.onPress, this.title = "Submit"});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Extrude(
        pressed: pressed,
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 17),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // pressed
                //     ? SizedBox(
                //         width: 15,
                //         height: 15,
                //         child: CircularProgressIndicator(
                //           strokeWidth: 2,
                //           backgroundColor: Theme.of(context).primaryColor,
                //           color: Colors.white,
                //         ),
                //       )
                //     : const SizedBox(),
                const SizedBox(width: 15),
                Text(title),
              ],
            )),
      ),
    );
  }
}
