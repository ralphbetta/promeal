import 'package:flutter/material.dart';

void main() {
  runApp(NeuromorphicButtonApp());
}

class NeuromorphicButtonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Extruded Neuromorphic Button')),
        body: Center(
          child: NeuromorphicButtonWidget(),
        ),
      ),
    );
  }
}

class NeuromorphicButtonWidget extends StatefulWidget {
  @override
  _NeuromorphicButtonWidgetState createState() =>
      _NeuromorphicButtonWidgetState();
}

class _NeuromorphicButtonWidgetState extends State<NeuromorphicButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPressed = !_isPressed;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.grey[400]!,
                    offset: Offset(8, 8),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.grey[400]!,
                    offset: Offset(4, 4),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-8, -8),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0E5EC),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Text(
          'Neuromorphic Button',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
