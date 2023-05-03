import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/datamodel.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/birth_date.dart';
import 'package:weight_loser/screens/Questions_screen/pregnant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/weight_screen.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import '../date_of_birth.dart';
import 'goal_weight_screen.dart';

class GenderScreen extends StatefulWidget {
  SignUpBody signUpBody;

  GenderScreen({Key key, this.signUpBody}) : super(key: key);

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String gender = '';

  List<Data> Gender = [
    Data('Male', ImagePath.male),
    Data('Female', ImagePath.female),
    Data('Non Binary', ImagePath.nonBinary)
  ];
  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
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
                  queNo: 4,
                  percent: .20,
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
                      'What is your gender?',
                      textAlign: TextAlign.center,
                      style: questionText30Px,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                ListView.builder(
                    itemCount: Gender.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  gender = Gender[index].text;
                                });
                              },
                              child: Container(
                                width: Get.width * .9,
                                height: 60,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                        width: 25,
                                        child: Image.asset(
                                          Gender[index].imageUrl,
                                          fit: BoxFit.contain,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      Gender[index].text,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: semiBold,
                                          fontFamily: 'Open Sans'),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: gender == Gender[index].text
                                          ? buttonColor
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    }),
              ],
            ),
            InkWell(
              onTap: () {
                print(gender);
                if (gender == 'Female') {
                  widget.signUpBody.dietQuestions.gender = gender;

                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BirthDate(
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
                                    child: BirthDate(
                                        signUpBody: widget.signUpBody)),
                              )));
                } else if (gender == 'Male' || gender == 'Non Binary') {
                  widget.signUpBody.dietQuestions.gender = gender;
                  Responsive1.isMobile(context)
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BirthDate(
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
                                    child: BirthDate(
                                        signUpBody: widget.signUpBody)),
                              )));
                } else {
                  AltDialog(context, 'Please select options.');
                }
                // if (gender == "Female") {
                //   widget.signUpBody.dietQuestions.gender = gender;
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => GoalWeightScreen(
                //             signUpBody: widget.signUpBody,
                //           )));
                // } else if (gender == 'Male' || gender == 'Intersex') {
                //   widget.signUpBody.dietQuestions.gender = gender;
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => GoalWeightScreen(
                //             signUpBody: widget.signUpBody,
                //           )));
                // } else {
                //   AltDialog(context, 'Please select options.');
                // }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                    width: Get.width * .6,
                    height: 40,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
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
    );
  }
}
