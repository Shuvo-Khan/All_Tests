import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(IntroApp());
}

class IntroApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Greeting App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello, World!',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Welcome to Flutter!',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Image.asset(
                'assets/images/messi.jpg',
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Button Pressed!'),
                    ));
                  },
                  child: Text('Press Me')),
            ],
          ),
        ));
  }
}
