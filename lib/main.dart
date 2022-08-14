import 'package:calcify/calcButtons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> allButtons = [
    '9',
    '8',
    '7',
    '×',
    '6',
    '5',
    '4',
    '/',
    '3',
    '2',
    '1',
    '-',
    '0',
    '=',
    '%',
    '+',
    '.',
    'C',
    'ANS',
    'DEL',
  ];

  bool isOperator(String isOperator) {
    if (isOperator == '×' ||
        isOperator == '/' ||
        isOperator == '-' ||
        isOperator == '+' ||
        isOperator == '%' ||
        isOperator == '=') {
      return true;
    } else {
      return false;
    }
  }

  void evaluateExpression() {
    String userFinalQues = userQues;
    userFinalQues = userFinalQues.replaceAll('×', '*');

    Parser p = Parser();
    Expression exp = p.parse(userFinalQues);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAns = eval.toString();
  }

  var userQues = '';
  var userAns = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(30),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userQues,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(30),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAns,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: allButtons
                      .length, // index will iterate from 0 to length of allButtons list
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 16 || index == 17 || index == 19) {
                      return CalcButtons(
                        btnText: allButtons[index],
                        btnColor: Colors.deepOrange[600],
                        btnTextColor: Colors.white,
                        buttonTapped: () {
                          if (index == 19) {
                            setState(() {
                              userQues =
                                  userQues.substring(0, userQues.length - 1);
                            });
                          } else if (index == 17) {
                            setState(() {
                              userQues = '';
                              userAns = '';
                            });
                          }
                        },
                      );
                    } else if (index == 13 || index == 18) {
                      return CalcButtons(
                          btnColor: Colors.brown,
                          btnTextColor: Colors.white,
                          btnText: allButtons[index],
                          buttonTapped: () {
                            setState(() {
                              evaluateExpression();
                            });
                          });
                    } else {
                      return CalcButtons(
                          btnText: allButtons[index],
                          btnColor: isOperator(allButtons[index])
                              ? Colors.indigo
                              : Colors.white,
                          btnTextColor: isOperator(allButtons[index])
                              ? Colors.white
                              : Colors.indigo,
                          buttonTapped: () {
                            setState(() {
                              userQues += allButtons[index];
                            });
                          });
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
