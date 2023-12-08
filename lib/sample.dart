
import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/theme.config.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key, required this.title});

  final String title;

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  bool _press = false;

  toggle() {
    setState(() {
      _press = !_press;
    });
  }

  @override
  Widget build(BuildContext context) {
    const darkIntrudeShadow = Color(0xFFC2C5CB);
    const lightIntrudeShadow = Color(0xFFFFFFFF);
    const backgroundColor = Color(0xFFF2F2F2);
    double borderRadius = 50;
    double blurRadius = 10;
    Offset extrueDistance = const Offset(4, 4);
    Offset insertDistance = const Offset(1, 4);
    double size = 50;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FirstExtrude(),
          const SizedBox(height: 20),
          AppButton(
              pressed: _press,
              onPress: () {
                toggle();
                AppTheme().switchTheme();
              })
        ],
      ),
    );
  }
}

