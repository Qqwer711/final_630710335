import 'dart:async';
import 'dart:io';
import 'package:final_630710335/model/Q.dart';
import 'package:final_630710335/service/api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Quiz>? Q;
  int C = 0;
  int inC = 0;
  String M = "";

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    List list = await Api().fetch('quizzes');
    setState(() {
      Q = list.map((item) => Quiz.fromJson(item)).toList();
    });
  }

  void guess(String choice) {
    setState(() {
      if (Q![C].answer == choice) {
        M = "ถูกต้องนะค้าบบบ";
      } else {
        M = "ตอบผิดจ้าาา ตอบใหม่นะ";
      }
    });
    Timer timer = Timer(Duration(seconds: 1), () {
      setState(() {
        M = "";
        if (Q![C].answer == choice) {
          C++;
        } else {
          inC++;
        }
      });
    });
  }

  Widget printGuess() {
    if (M.isEmpty) {
      return SizedBox(height: 30, width: 20);
    } else if (M == "ถูกต้องนะค้าบบบ") {
      return Text(M);
    } else {
      return Text(M);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Q != null && C < Q!.length-1
          ? buildQuiz()
          : Q != null && C == Q!.length-1
          ? buildTryAgain()
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildTryAgain() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('เกมจบแล้วจ้าาา♥♥'),
            Text('ตอบผิด ${inC} ครั้ง'),
          ],
        ),
      ),
    );
  }

  Padding buildQuiz() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(Q![C].image_url, fit: BoxFit.cover),
            Column(
              children: [
                for (int i = 0; i < Q![C].choices.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                guess(Q![C].choices[i].toString()),
                            child: Text(Q![C].choices[i]),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            printGuess(),
          ],
        ),
      ),
    );
  }
}