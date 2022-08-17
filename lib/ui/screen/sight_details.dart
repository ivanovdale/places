import 'package:flutter/material.dart';

class SightDetails extends StatelessWidget {

  const SightDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 24.0,
                        left: 16.0,
                      ),
                      child: Text(
                        'Пряности и радости',
                        style: TextStyle(
                          color: Color.fromARGB(255, 59, 62, 91),
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 2.0,
                          left: 16.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ресторан',
                            style: TextStyle(
                              color: Color.fromARGB(255, 59, 62, 91),
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 2.0,
                          left: 16.0,
                        ),
                        child: Text(
                          'закрыто до 09:00',
                          style: TextStyle(
                            color: Color.fromARGB(255, 124, 126, 146),
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Text(
                      'Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного',
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 62, 91),
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 76, 175, 80),
                      ),
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 22,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'построить маршрут',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 24,
                      left: 16,
                      right: 16,
                      bottom: 19,
                    ),
                    child: Divider(thickness: 0.8,),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 22,
                              height: 19,
                              color: const Color.fromARGB(143, 124, 126, 146),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            const Text(
                              'Запланировать',
                              style: TextStyle(
                                color: Color.fromARGB(143, 124, 126, 146),
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 18,
                              color: const Color.fromARGB(255, 59, 62, 91),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            const Text(
                              'В Избранное',
                              style: TextStyle(
                                color: Color.fromARGB(255, 59, 62, 91),
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
