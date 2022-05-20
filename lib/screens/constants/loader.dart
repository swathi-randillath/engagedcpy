import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff1D3149),
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Color(0xff228BDB),
          strokeWidth: 8,
        ),
      ),
    );
  }
}
