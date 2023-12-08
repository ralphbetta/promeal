import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/provider/theme.provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeClass.themeNotifier,
      builder: (_,ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: currentMode,
          theme: ThemeClass.lightTheme,
          darkTheme: ThemeClass.darkTheme,
          home: const MyHomePage(title: 'Component Home'),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _press = false;

  toggle() {
    setState(() {
      _press = !_press;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const SizedBox(height: 20),
          AppButton(
              pressed: _press,
              onPress: () {
               
                toggle();
              })
        ],
      ),
    );
  }
}

