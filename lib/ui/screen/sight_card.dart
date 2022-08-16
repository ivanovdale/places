import 'package:flutter/material.dart';

import 'package:places/domain/sight.dart';

class SightCard extends StatelessWidget {
  Sight sight;

  SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 360,
          child: Stack(
            children: [
              Container(
                color: Colors.lightBlue.shade800,
              ),
              Positioned(
                left: 16,
                top: 36,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  width: 32,
                  height: 32,
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 15.0,
                    color: Color.fromARGB(255, 37, 40, 73),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 336,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
