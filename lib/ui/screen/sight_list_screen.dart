import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 136,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Список\nинтересных мест',
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto', fontSize: 32, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
