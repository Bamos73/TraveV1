import 'package:flutter/material.dart';
import 'package:shopapp/size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String routeName = "/cart/components";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showContainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          width: _showContainer ? MediaQuery.of(context).size.width : 0,
          height: _showContainer ? MediaQuery.of(context).size.height : 0,
          color: Colors.green,
          child: Text("Hello, world!"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showContainer = !_showContainer;
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}