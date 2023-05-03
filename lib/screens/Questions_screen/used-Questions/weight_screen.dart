import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/screens/Questions_screen/weightmsg.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'gender_screen.dart';
import 'goal_weight_screen.dart';

class WeightScreen extends StatefulWidget {
  SignUpBody signUpBody;

  WeightScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  int _currentIntValue = 10;
  double _currentDoubleValue = 3.0;
  NumberPicker firstNumberPicker;
  NumberPicker secondNumberPicker;
  int _currentKGValue = 50;

  int _currentLbsValue = 173;
  String mode = 'KG';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: height * .01,
                ),
                questionHeader(
                  queNo: 2,
                  percent: .10,
                  color: primaryColor,
                ),
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'What is your current\n weight?',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                Container(
                    width: Get.width * .32,
                    height: 20,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              mode = 'lbs';
                            });
                          },
                          child: Container(
                              width: Get.width * .15,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: mode == 'lbs'
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(40.0),
                                      topLeft: Radius.circular(40.0))),
                              child: Center(
                                  child: Text(
                                'lbs',
                                style: TextStyle(
                                    color: mode == 'lbs'
                                        ? Colors.white
                                        : Colors.black),
                              ))),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              mode = 'KG';
                            });
                          },
                          child: Container(
                              width: Get.width * .15,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: mode == 'KG'
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0))),
                              child: Center(
                                  child: Text(
                                'KG',
                                style: TextStyle(
                                    color: mode == 'KG'
                                        ? Colors.white
                                        : Colors.black),
                              ))),
                        ),
                      ],
                    )),
                SizedBox(
                  height: height * .1,
                ),
                mode == 'lbs'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 1.5,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                          ),
                          NumberPicker(
                            value: _currentLbsValue,
                            itemWidth: 60,
                            selectedTextStyle: selectedStyle,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(color: Colors.black26),
                            ),
                            minValue: 0,
                            maxValue: 10000,
                            onChanged: (value) =>
                                setState(() => _currentLbsValue = value),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 1.5,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Center(
                              child: Text(
                                'lbs',
                                style: wordStyle,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 1.5,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                          ),
                          NumberPicker(
                            value: _currentKGValue,
                            itemWidth: 60,
                            selectedTextStyle: selectedStyle,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(color: Colors.black26),
                            ),
                            minValue: 0,
                            maxValue: 10000,
                            onChanged: (value) =>
                                setState(() => _currentKGValue = value),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              width: 1.5,
                              height: 150,
                              color: Colors.grey[300],
                            ),
                          ),
                          Container(
                            height: 150,
                            child: Center(
                              child: Text('KG', style: wordStyle),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            InkWell(
              onTap: () {
                if (mode == 'KG') {
                  widget.signUpBody.dietQuestions.currentWeight =
                      _currentKGValue;
                  widget.signUpBody.dietQuestions.weightUnit = 'kg';
                  print('$_currentKGValue KG');

                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GoalWeightScreen(
                                signUpBody: widget.signUpBody,
                              )))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: GoalWeightScreen(
                                        signUpBody: widget.signUpBody)),
                              )));
                } else if (mode == 'lbs') {
                  widget.signUpBody.dietQuestions.currentWeight =
                      _currentLbsValue;
                  widget.signUpBody.dietQuestions.weightUnit = 'lbs';
                  print('$_currentLbsValue Lbs');

                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GoalWeightScreen(
                                signUpBody: widget.signUpBody,
                              )))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: GoalWeightScreen(
                                        signUpBody: widget.signUpBody)),
                              )));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Center(
                      child: Text(
                        "Next",
                        style: buttonStyle,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
