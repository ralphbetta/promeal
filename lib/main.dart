import 'package:flutter/material.dart';
import 'package:promeal/components/button.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:promeal/provider/theme.provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppProvider()),
    ChangeNotifierProvider(create: (_) => AccountProvider()),
   ChangeNotifierProvider(create: (_) => EventProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeClass.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            title: 'ProMeal App',
            themeMode: currentMode,
            theme: ThemeClass.lightTheme,
            darkTheme: ThemeClass.darkTheme,
            home: const StartUp(),
          );
        });
  }
}

class StartUp extends StatelessWidget {
  const StartUp({super.key});

  @override
  Widget build(BuildContext context) {
    timeOut() async {
      AppSize().init(context);

      if (context.mounted) {
       bool validated =  await context.read<AccountProvider>().validateAuthentication(context);
       if(validated){

       }
      }
    }

    timeOut();

    return Scaffold(
      body: Container(
        child:
         Center(
          child: Image(
          image: ThemeClass.themeNotifier.value == ThemeMode.dark ? AssetImage(AppAsset.logodark) :  AssetImage(AppAsset.logolight),
          width: AppSize.width(20),
          )
          
          ),
      ),
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
