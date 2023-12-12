import 'package:flutter/material.dart';
import 'package:promeal/config/size.config.dart';

class FoodcardCounter extends StatelessWidget {
  final bool trasfered;
  const FoodcardCounter({
    super.key,
    this.trasfered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).shadowColor.withOpacity(0.5),
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.background,
              ])),
      padding: const EdgeInsets.symmetric(vertical: 3),
      width: AppSize.width(15),
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("0"),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      trasfered
                          ? Theme.of(context).primaryColor
                          : const Color(0xFFFFC220),
                      const Color(0xFFA19C7A),
                    ]),
                borderRadius: BorderRadius.circular(3)),
            child: Text(
              trasfered ? "Transfer" : "Claimed",
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}