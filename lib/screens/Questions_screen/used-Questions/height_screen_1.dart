import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/customer_pkgs.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ColorConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/question_Header.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({Key key}) : super(key: key);

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  SignUpBody signUpBody = SignUpBody();
  int _currentIntValue = 10;
  double _currentDoubleValue = 3.0;
  NumberPicker firstNumberPicker;
  NumberPicker secondNumberPicker;
  int _currentValue1 = 3;
  int _currentValue2 = 5;
  int _currentCmValue = 173;
  String mode = 'feet';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpBody.customerPackages = CustomerPackages();
    signUpBody.dietQuestions = DietQuestions();
    signUpBody.mindQuestions = MindQuestions();
    signUpBody.exerciseQuestions = ExerciseQuestions();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height; //683
    var width = MediaQuery.of(context).size.width; //411

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
                  queNo: 1,
                  percent: .05,
                  color: primaryColor,
                ),
                SizedBox(
                  height: height * .05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'What is your height?',
                    style: questionText30Px,
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
                              mode = 'feet';
                            });
                          },
                          child: Container(
                              width: Get.width * .15,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: mode == 'feet'
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(40.0),
                                      topLeft: Radius.circular(40.0))),
                              child: Center(
                                  child: Text(
                                'Ft',
                                style: TextStyle(
                                    color: mode == 'feet'
                                        ? Colors.white
                                        : Colors.black),
                              ))),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              mode = 'Cm';
                            });
                          },
                          child: Container(
                              width: Get.width * .15,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: mode == 'Cm'
                                      ? primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0))),
                              child: Center(
                                  child: Text(
                                'Cm',
                                style: TextStyle(
                                    color: mode == 'Cm'
                                        ? Colors.white
                                        : Colors.black),
                              ))),
                        ),
                      ],
                    )),
                SizedBox(
                  height: height * .1,
                ),
                mode == 'feet'
                    ? Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Container(
                                    width: 1.5,
                                    height: 157,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                NumberPicker(
                                  value: _currentValue1,
                                  itemWidth: 60,
                                  selectedTextStyle: selectedStyle,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                  minValue: 0,
                                  maxValue: 12,
                                  onChanged: (value) =>
                                      setState(() => _currentValue1 = value),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Container(
                                    width: 1.5,
                                    height: 150,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 150,
                              child: const Center(
                                child: Text(
                                  'ft',
                                  style: wordStyle,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Container(
                                    width: 1.5,
                                    height: 150,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                NumberPicker(
                                  value: _currentValue2,
                                  itemWidth: 60,
                                  selectedTextStyle: selectedStyle,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                  minValue: 0,
                                  maxValue: 12,
                                  onChanged: (value) =>
                                      setState(() => _currentValue2 = value),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Container(
                                    width: 1.5,
                                    height: 150,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 150,
                              child: Center(
                                child: Text(
                                  'in',
                                  style: wordStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            value: _currentCmValue,
                            itemWidth: 60,
                            selectedTextStyle: selectedStyle,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(color: Colors.black26),
                            ),
                            minValue: 0,
                            maxValue: 10000,
                            onChanged: (value) =>
                                setState(() => _currentCmValue = value),
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
                                'Cm',
                                style: wordStyle,
                              ),
                            ),
                          )
                        ],
                      ),
              ],
            ),
            InkWell(
              onTap: () {
                if (mode == 'feet') {
                  var a = '$_currentValue1.$_currentValue2'.trim();
                  var b = _currentValue1 * _currentValue2;
                  signUpBody.dietQuestions.height =
                      double.parse('$_currentValue1.$_currentValue2');
                  signUpBody.dietQuestions.heightUnit = 'feet';
                  print(a + signUpBody.dietQuestions.heightUnit);

                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              WeightScreen(signUpBody: signUpBody)))
                      : Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 430, right: 430, top: 30, bottom: 30),
                                child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child:
                                        WeightScreen(signUpBody: signUpBody)),
                              )));
                } else if (mode == 'Cm') {
                  signUpBody.dietQuestions.height =
                      double.parse('$_currentCmValue');
                  signUpBody.dietQuestions.heightUnit = 'cm';
                  print(
                      '$_currentCmValue' + signUpBody.dietQuestions.heightUnit);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WeightScreen(
                            signUpBody: signUpBody,
                          )));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
