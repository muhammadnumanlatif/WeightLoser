import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/datamodel.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/not_support_medical_condition.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';
import 'diet _exercise_mind.dart';
import '../how_much_move_day.dart';
import 'not_support_pregnant.dart';

class DoYouHaveFollowingMedicalConditions extends StatefulWidget {
  SignUpBody signUpBody;

  DoYouHaveFollowingMedicalConditions({Key key, this.signUpBody})
      : super(key: key);

  @override
  _DoYouHaveFollowingMedicalConditionsState createState() =>
      _DoYouHaveFollowingMedicalConditionsState();
}

class _DoYouHaveFollowingMedicalConditionsState
    extends State<DoYouHaveFollowingMedicalConditions> {
  String gender = '';
  List selectedOptions = [];
  List<Data> medicalCondition = [
    Data("High blood pressure", ImagePath.highBlood),
    Data("Heart disease or stroke", ImagePath.heartStroke),
    Data("Diabetes", ImagePath.diabetes),
    Data("Kidney diseases", ImagePath.kidney),
    Data("High cholesterol", ImagePath.colestrol),
    Data("Severe Arthritis", ImagePath.severer),
    Data("Liver disease", ImagePath.liver),
    Data("Depression", ImagePath.depression),
    Data("Chronic back pain", ImagePath.backPain),
    Data("Eating disorders", ImagePath.eatingDisorder),
    Data("None", '')

    //	"Eating disorders such as Bulimia Nervosa, Anorexia Nervosa, bothor binge eating disorder"
  ];

  @override
  Widget build(BuildContext context) {
    var mobile = Responsive1.isMobile(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    bool _canshow = false;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: height * .01,
                          ),
                          questionHeader(
                            queNo: 6,
                            percent: .30,
                            color: primaryColor,
                          ),
                          SizedBox(
                            height: height * .05,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.pop(context);
                          //         print("tapped");
                          //       },
                          //       child: Container(
                          //         child: Icon(
                          //           Icons.arrow_back,
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //     ),
                          //     Row(
                          //       children: [
                          //         Text(
                          //           '15/$totalQuestion',
                          //           style: TextStyle(color: Colors.black),
                          //         )
                          //       ],
                          //     ),
                          //     Container()
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Container(
                          //   width: double.infinity,
                          //   height: 5,
                          //   color: Colors.grey[300],
                          //   child: LinearPercentIndicator(
                          //     // width: double.infinity,
                          //     lineHeight: 5.0,
                          //     percent: .34,
                          //
                          //     padding: EdgeInsets.all(0),
                          //     backgroundColor: Colors.grey[300],
                          //     progressColor: primaryColor,
                          //   ),
                          // ),
                          Container(
                              height:
                                  mobile ? Get.height * .70 : Get.height * .80,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Do you have any of the Medical Conditions?',
                                          textAlign: TextAlign.center,
                                          style: questionText30Px,
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   width: double.infinity,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: Text(
                                    //       'Choose as many as you like: ( Minimum 3)',
                                    //       textAlign: TextAlign.center,
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: height * .03,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: medicalCondition.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 25, right: 25),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (medicalCondition[
                                                                  index]
                                                              .text ==
                                                          "None") {
                                                        selectedOptions.clear();
                                                        selectedOptions
                                                            .add("None");
                                                      } else if (selectedOptions
                                                          .contains(
                                                              medicalCondition[
                                                                      index]
                                                                  .text)) {
                                                        selectedOptions.remove(
                                                            medicalCondition[
                                                                    index]
                                                                .text);
                                                      } else {
                                                        selectedOptions
                                                            .remove("None");
                                                        selectedOptions.add(
                                                            medicalCondition[
                                                                    index]
                                                                .text);
                                                      }

                                                      gender = medicalCondition[
                                                              index]
                                                          .text;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: Get.width * .9,
                                                    height: 60,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: medicalCondition[
                                                                            index]
                                                                        .text !=
                                                                    "None"
                                                                ? Image.asset(
                                                                    medicalCondition[
                                                                            index]
                                                                        .imageUrl)
                                                                : SizedBox
                                                                    .shrink()),
                                                        Text(
                                                          medicalCondition[
                                                                  index]
                                                              .text,
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: selectedOptions
                                                                  .contains(
                                                                      medicalCondition[
                                                                              index]
                                                                          .text)
                                                              ? primaryColor
                                                              : Colors.grey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 20, 0, 0),
              child: InkWell(
                onTap: () {
                  if (selectedOptions.contains("Liver disease") ||
                      selectedOptions.contains("Severe Arthritis") ||
                      selectedOptions.contains("Chronic back pain") ||
                      selectedOptions.contains("Eating disorders")) {
                    mobile
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotSupportMedicalCondition(
                                  signUpBody: widget.signUpBody,
                                )))
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 430,
                                      right: 430,
                                      top: 30,
                                      bottom: 30),
                                  child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: NotSupportMedicalCondition(
                                        signUpBody: widget.signUpBody,
                                      )),
                                )));
                  } else if (selectedOptions.isNotEmpty) {
                    if (selectedOptions.contains("None"))
                      widget.signUpBody.dietQuestions.medicalCondition = "none";
                    else
                      widget.signUpBody.dietQuestions.medicalCondition =
                          selectedOptions.toString();
                    print(widget.signUpBody.dietQuestions.medicalCondition);
                    mobile
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DietExerciseMindScreen(
                                  signUpBody: widget.signUpBody,
                                )))
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 430,
                                      right: 430,
                                      top: 30,
                                      bottom: 30),
                                  child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DietExerciseMindScreen(
                                        signUpBody: widget.signUpBody,
                                      )),
                                )));
                  } else {
                    mobile
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DietExerciseMindScreen(
                                  signUpBody: widget.signUpBody,
                                )))
                        : Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 430,
                                      right: 430,
                                      top: 30,
                                      bottom: 30),
                                  child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: DietExerciseMindScreen(
                                        signUpBody: widget.signUpBody,
                                      )),
                                )));
                  }
                },
                child: Padding(
                  padding: mobile
                      ? const EdgeInsets.only(bottom: 13, left: 20)
                      : const EdgeInsets.only(bottom: 30.0, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: mobile ? Get.width * .6 : Get.width * .3,
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
