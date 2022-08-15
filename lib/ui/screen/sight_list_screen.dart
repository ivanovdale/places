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
        title: RichText(
          text: const TextSpan(
            text: 'С',
            style: TextStyle(
              color: Color.fromARGB(255, 76, 175, 80),
              fontFamily: 'Roboto',
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: 'писок\n',
                style: TextStyle(
                  color: Color.fromARGB(255, 37, 40, 73),
                ),
              ),
              TextSpan(
                text: 'и',
                style: TextStyle(
                  color: Color.fromARGB(255, 252, 221, 61),
                ),
                children: [
                  TextSpan(
                    text: 'нтересных мест',
                    style: TextStyle(
                      color: Color.fromARGB(255, 37, 40, 73),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
