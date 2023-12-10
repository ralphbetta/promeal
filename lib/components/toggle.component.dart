import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';

class AppToggle extends StatefulWidget {
   final bool active ;
   final Function()? onTap;
   const AppToggle({
    super.key, this.active = false, this.onTap
  });

  @override
  State<AppToggle> createState() => _AppToggleState();
}

class _AppToggleState extends State<AppToggle> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children:   [
       const SizedBox(
          width: 40,
          height: 20,
        ),

       const Positioned(
          top: 2,
          bottom: 0,
          child: Extrude(pressed: true, inset: 2, 
          child: SizedBox(height: 14, width: 40),
          ),
        ),

        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          left: !widget.active ? 1 : 20,
          child:   Extrude(inset: 2, 
          onPress:()=> widget.onTap!(),
          primary: widget.active, 
        child: const SizedBox(height: 20, width: 20)))
      ],
    );
  }
}
