import 'dart:math';
import 'package:bmi_calculator/src/components/container_box.dart';
import 'package:bmi_calculator/src/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/data_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color maleBoxColor = activeColor;
  Color femaleBoxColor = inActiveColor;
  int height = 180;
  int weight = 20;
  int age = 25;
  String result = "";
  String resultDetail = "Result here";
  double bmi = 0;

  void updateBoxColor(int gender) {
    if (gender == 1) {
      if (maleBoxColor == inActiveColor) {
        maleBoxColor = activeColor;
        femaleBoxColor = inActiveColor;
      } else {
        maleBoxColor = inActiveColor;
        femaleBoxColor = activeColor;
      }
    } else {
      if (femaleBoxColor == inActiveColor) {
        femaleBoxColor = activeColor;
        maleBoxColor = inActiveColor;
      } else {
        femaleBoxColor = inActiveColor;
        maleBoxColor = activeColor;
      }
    }
  }

  String calculateBmi(int weight, int height) {
    double bmi = weight / pow(height / 100, 2);
    return bmi.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0.0,
        centerTitle: true,
        title: SvgPicture.asset('assets/logo.svg', color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateBoxColor(1);
                    });
                  },
                  child: ContainerBox(
                    boxColor: maleBoxColor,
                    childwidget: const DataContainer(
                      icon: Icons.male,
                      title: 'MALE',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      updateBoxColor(2);
                    });
                  },
                  child: ContainerBox(
                    boxColor: femaleBoxColor,
                    childwidget: const DataContainer(
                      icon: Icons.female,
                      title: 'FEMALE',
                    ),
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            child: ContainerBox(
              boxColor: inActiveColor,
              childwidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'HEIGHT',
                    style: textStyle1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: textStyle2,
                      ),
                      const Text(
                        'cm',
                        style: textStyle1,
                      ),
                    ],
                  ),
                  Slider(
                    value: height.toDouble(),
                    min: 120,
                    max: 220,
                    activeColor: activeColor,
                    inactiveColor: inActiveColor,
                    onChanged: (double newValue) {
                      setState(() {
                        height = newValue.round();
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                child: ContainerBox(
                  boxColor: inActiveColor,
                  childwidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'WEIGHT',
                        style: textStyle1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            weight.toString(),
                            style: textStyle2,
                          ),
                          const Text(
                            'kg',
                            style: textStyle1,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                            backgroundColor: activeColor,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                if (weight > 0) {
                                  weight--;
                                }
                              });
                            },
                            backgroundColor: activeColor,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ContainerBox(
                  boxColor: inActiveColor,
                  childwidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'AGE',
                        style: textStyle1,
                      ),
                      Text(
                        age.toString(),
                        style: textStyle2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                if (age < 100) {
                                  age++;
                                }
                              });
                            },
                            backgroundColor: activeColor,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                if (age > 0) {
                                  age--;
                                }
                              });
                            },
                            backgroundColor: activeColor,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
          GestureDetector(
              onTap: () {
                setState(() {
                  result = calculateBmi(weight, height);
                  /*resultDetail = getInterpretation(bmi);*/
                  showDialog(
                      context: context,
                      builder: (BuildContext contest) {
                        return Dialog(
                            backgroundColor: inActiveColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              color: inActiveColor,
                              height: 200.0,
                              margin: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'Your BMI',
                                    style: textStyle1,
                                  ),
                                  Text(
                                    result.toString(),
                                    style: textStyle2,
                                  ),
                                  /*Text(
                                    resultDetail,
                                    style: textStyle1,
                                  ),*/
                                ],
                              ),
                            ));
                      });
                });
              },
              child: Container(
                width: 380.0,
                height: 64.0,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.only(top: 10.0),
                child: const Center(
                  child: Text(
                    'Calculate',
                    style: textStyle3,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
