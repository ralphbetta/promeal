import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Component Home'),
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

          AttemptOnState(),
          SizedBox(height: 20),

          Extrude(
            pressed: _press,
            body: Container(
                padding: const EdgeInsets.symmetric(vertical: 17),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !_press
                        ? SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              backgroundColor: Theme.of(context).primaryColor,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(width: 15),
                    const Text("SIGN UP"),
                  ],
                )),
            onPress: () {
              toggle();

              print(_press);
            },
          )
        ],
      ),
    );
  }
}



class AttemptOnState extends StatefulWidget {
  const AttemptOnState({super.key});

  @override
  State<AttemptOnState> createState() => _AttemptOnStateState();
}

class _AttemptOnStateState extends State<AttemptOnState> {
  bool _press = false;

  toggle() {
    setState(() {
      _press = !_press;
    });
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7ECEF);
    const rightLightShadowColor = Color(0xFFA7A9AF);
    const leftLightShadowColor = Color(0xFFFFFFFF);
    double borderRadius = 5;
    double blurRadius = 9;
    Offset distance = const Offset(4, 4);
    Offset insertDistance = const Offset(1, 2);

    double size = 100;
    return Column(
      children: [
        // Square
        !_press
            ? GestureDetector(
                onTap: () {
                  toggle();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                        boxShadow: [
                          BoxShadow(
                            offset: -distance,
                            color: leftLightShadowColor,
                            blurRadius: blurRadius,
                          ),
                          BoxShadow(
                              offset: distance,
                              color: rightLightShadowColor,
                              blurRadius: blurRadius)
                        ]),
                    child: SizedBox(
                      width: size,
                      height: size,
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  toggle();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(color: rightLightShadowColor),
                        BoxShadow(
                            offset: insertDistance,
                            blurRadius: blurRadius - 4,
                            color: backgroundColor // background color
                            ),
                      ],
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: SizedBox(
                      width: size,
                      height: size,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class Extrude extends StatelessWidget {
  final Widget body;
  final double radius;
  final bool pressed;
  final Function()? onPress;
  const Extrude(
      {super.key,
      this.body = const SizedBox(),
      this.radius = 10,
      required this.pressed,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    const darkIntrudeShadow = Color(0xFFC2C5CB);
    const lightIntrudeShadow = Color(0xFFFFFFFF);
    const backgroundColor = Color(0xFFF2F2F2);

    double blurRadius = 10;
    Offset extrueDistance = const Offset(4, 4);
    Offset insertDistance = const Offset(1, 4);

    return Column(
      children: [
        pressed
            ? GestureDetector(
                onTap: onPress,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(radius),
                        boxShadow: [
                          BoxShadow(
                            offset: -extrueDistance,
                            color: lightIntrudeShadow,
                            blurRadius: blurRadius,
                          ),
                          BoxShadow(
                              offset: extrueDistance,
                              color: darkIntrudeShadow,
                              blurRadius: blurRadius)
                        ]),
                    child: body,
                  ),
                ),
              )
            : GestureDetector(
                onTap: onPress,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(color: darkIntrudeShadow),
                        BoxShadow(
                            offset: insertDistance,
                            blurRadius: blurRadius - 4,
                            color: backgroundColor // background color
                            ),
                      ],
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: body,
                  ),
                ),
              ),
      ],
    );
  }
}
