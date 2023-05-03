import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/date_of_birth.dart';
import 'package:weight_loser/screens/Questions_screen/pregnant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/screens/Questions_screen/when_goal_weight_last_time.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'gender_screen.dart';
import 'love_food.dart';

class DietExerciseMindScreen extends StatefulWidget {
  SignUpBody signUpBody;
  DietExerciseMindScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _DietExerciseMindScreenState createState() => _DietExerciseMindScreenState();
}

class _DietExerciseMindScreenState extends State<DietExerciseMindScreen> {
  int _currentIntValue = 10;
  double _currentDoubleValue = 3.0;
  NumberPicker firstNumberPicker;
  NumberPicker secondNumberPicker;
  int _currentKGValue = 50;
  int _currentCmValue = 173;
  String mode = 'KG';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                  questionHeaderSimple(
                    percent: .98,
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Column(
                        children: [
                          Text(
                            'Weightloser provides you with\nfully customized diet based\nupon your answers!',
                            textAlign: TextAlign.center,
                            style: questionText28Px,
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Weight loss dose not resolve around diet only.\nIt\'s a combination of:',
                            textAlign: TextAlign.center,
                            style: subNotSupport,
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Diet + Exercise + Mental Strength',
                            textAlign: TextAlign.center,
                            style: subNotSupport,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Container(
                      height: Responsive1.isMobile(context) ? 350 : 270,
                      //width: Get.width * .5,
                      child: Image.asset(
                        ImagePath.dietMind,
                        fit: BoxFit.contain,
                      )),
                ],
              ),
              InkWell(
                onTap: () {
                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoveFood(
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
                                    child: LoveFood(
                                        signUpBody: widget.signUpBody)),
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                      width: Get.width * .6,
                      height: 40,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
