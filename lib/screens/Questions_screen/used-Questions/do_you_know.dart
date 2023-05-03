import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/sleep_time.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weightLoss_journey.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'do_you_have_any_of_the_following_medical_conditions.dart';

class DoyouknowScreen extends StatefulWidget {
  SignUpBody signUpBody;
  DoyouknowScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _DoyouknowScreenState createState() => _DoyouknowScreenState();
}

class _DoyouknowScreenState extends State<DoyouknowScreen> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
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
                    percent: .99,
                    color: exBorder,
                  ),
                  SizedBox(height: height * .05),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Do you know?',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Even ⅓rd of reduction of your goal weight ( users weight loss goal)\nyou can reduce your risks for diabetes, high blood pressure,\nhigh cholesterol, metabolicsyndrome, and heart diseases.',
                        textAlign: TextAlign.center,
                        style: darkText12Px,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Container(
                      height: mobile ? 300 : 250,
                      //width: Get.width * .5,
                      child: Image.asset(
                        ImagePath.doYou,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: height * .03),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Here, you have 24x7 access to nutritional, exercise, and mind\n coaches who answer any of your questions 24 hours a day.\nWe work together closely to make you healthy.',
                        textAlign: TextAlign.center,
                        style: darkText12Px,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  mobile
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WeightLossJourney(
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
                                    child: WeightLossJourney(
                                      signUpBody: widget.signUpBody,
                                    )),
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
                          style: buttonStyle,
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
