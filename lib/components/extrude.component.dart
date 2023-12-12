import 'package:flutter/material.dart';
import 'package:promeal/config/color.config.dart';
import 'package:promeal/config/theme.config.dart';
import 'package:promeal/provider/theme.provider.dart';

//This File contains Extrusion n first extrution

class Extrude extends StatelessWidget {
  final Widget child;
  final double radius;
  final bool pressed;
  final double inset;
  final bool primary;
  final Function()? onPress;
  const Extrude(
      {super.key,
      this.inset = 5,
      this.child = const SizedBox(),
      this.radius = 10,
      this.pressed = false,
      this.onPress,
      this.primary = false});

  @override
  Widget build(BuildContext context) {
    // Color? scaffoldL =const Color(0xFFE0E0E0);
    // Color scaffoldLL = const Color(0xFFEEEEEE);
    // Color? shadowL =const Color(0xFF9E9E9E);
    // Color? backgroundL = const Color(0xFFFFFF);

    double extrudeBlurRadius = 5;
    Offset extrueDistance = const Offset(4, 4);
    Offset insertDistance = const Offset(1, 4);

    return Column(
      children: [
        !pressed
            ? GestureDetector(
                onTap: onPress,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary
                            ? null
                            : Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(radius),
                        gradient: primary
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                    AppColors.primaryDark,
                                     AppColors.primaryDark,
                             
                                    AppColors.primary,
                                  ])
                            : null,
                        boxShadow: [
                          //top region
                          BoxShadow(
                            offset: -extrueDistance,
                            color: Theme.of(context).secondaryHeaderColor,
                            blurRadius: extrudeBlurRadius,
                          ),
                          //bottom region
                          BoxShadow(
                            offset: extrueDistance,
                            color: Theme.of(context).shadowColor,
                            blurRadius: extrudeBlurRadius,
                          ),
                        ]),
                    child: child,
                  ),
                ),
              )

            //intrude
            : GestureDetector(
                onTap: onPress,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: primary ? const Color(0xFF04794B) : Theme.of(context).shadowColor,
                          offset: const Offset(1, 2)),
                      BoxShadow(
                          offset: insertDistance,
                          blurRadius: inset,
                          color: primary ? AppColors.primary : Theme.of(context)
                              .scaffoldBackgroundColor // background color
                          ),
                    ],
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: child,
                ),
              ),
      ],
    );
  }
}

//This File contains Extrusion n first extrution

class Extrude2 extends StatelessWidget {
  final Widget body;
  final double radius;
  final bool pressed;
  final Function()? onPress;
  const Extrude2(
      {super.key,
      this.body = const SizedBox(),
      this.radius = 10,
      required this.pressed,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    // const darkIntrudeShadow = Color(0xFFC2C5CB);
    // const lightIntrudeShadow = Color(0xFFFFFFFF);
    // const backgroundColor = Color(0xFFF2F2F2);

    double blurRadius = 10;
    Offset extrueDistance = const Offset(4, 4);
    Offset insertDistance = const Offset(1, 4);

    return Column(
      children: [
        !pressed
            ? GestureDetector(
                onTap: onPress,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        // ThemeClass.themeNotifier.value == ThemeMode.dark
                        //  ? Theme.of(context).scaffoldBackgroundColor
                        //  : Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(radius),
                        boxShadow: [
                          BoxShadow(
                            offset: -extrueDistance,
                            color:
                                ThemeClass.themeNotifier.value == ThemeMode.dark
                                    ? //Theme.of(context).shadowColor
                                    Colors.grey.withOpacity(0.09)
                                    : Theme.of(context).colorScheme.background,

                            //Theme.of(context).shadowColor,
                            blurRadius: blurRadius,
                          ),
                          BoxShadow(
                              offset: extrueDistance,
                              color: ThemeClass.themeNotifier.value !=
                                      ThemeMode.dark
                                  ? Theme.of(context).shadowColor
                                  : Theme.of(context).colorScheme.background,
                              //Theme.of(context).colorScheme.background,
                              blurRadius: blurRadius)
                        ]),
                    child: body,
                  ),
                ),
              )

            //intrude
            : GestureDetector(
                onTap: onPress,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Theme.of(context).shadowColor),
                        BoxShadow(
                            offset: insertDistance,
                            blurRadius: blurRadius - 4,
                            color: Theme.of(context)
                                .scaffoldBackgroundColor // background color
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

class FirstExtrude extends StatefulWidget {
  const FirstExtrude({super.key});

  @override
  State<FirstExtrude> createState() => _FirstExtrudeState();
}

class _FirstExtrudeState extends State<FirstExtrude> {
  bool _press = false;

  toggle() {
    setState(() {
      _press = !_press;
    });
    AppTheme().switchTheme();
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
