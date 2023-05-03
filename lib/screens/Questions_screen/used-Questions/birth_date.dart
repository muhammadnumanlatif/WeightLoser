import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:weight_loser/utils/TextConstant.dart';
import 'package:weight_loser/widget/dialog.dart';
import 'package:weight_loser/widget/question_Header.dart';

import 'do_you_have_any_of_the_following_medical_conditions.dart';
import 'not_support_pregnant.dart';

class BirthDate extends StatefulWidget {
  SignUpBody signUpBody;
  BirthDate({this.signUpBody});
  @override
  State<BirthDate> createState() => _BirthDateState();
}

class _BirthDateState extends State<BirthDate> {
  int age;
  DateTime _selectedDate = DateTime.now();

  TextEditingController date = TextEditingController();
  Future _selectDate(BuildContext context) async {
    /*
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    */
    var today = DateFormat('dd/MM/yyyy').format(_selectedDate).toString();
    if (date.text.trim().isNotEmpty != null &&
        date.text.trim().toString() != today) {
      setState(() {
        _selectedDate =
            DateFormat('dd/MM/yyyy').parse(date.text.trim().toString());
        print(_selectedDate);
      });
    }
  }

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
                  questionHeader(
                    queNo: 5,
                    percent: .25,
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
                        'What is your date of birth?',
                        textAlign: TextAlign.center,
                        style: questionText30Px,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 70, right: 70, top: 60, bottom: 15),
                    child: TextField(
                      // maxLength: 10,
                      keyboardType: TextInputType.datetime,
                      controller: date,

                      //focusNode: _focusNodeDOB,
                      decoration: InputDecoration(
                          hintText: 'DD/MM/YYYY',
                          counterText: '',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              fontWeight: medium),
                          suffixIcon: GestureDetector(
                              onTap: () {}, child: Icon(Icons.calendar_today))),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                        LengthLimitingTextInputFormatter(10),
                        _DateFormatter(),
                      ],
                    ),
                    /*
                    child: TextFormField(
                      controller: date,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "DD/MM/YYYY",
                          hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              fontWeight: medium),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                // _selectDate(context);
                              },
                              child: Icon(Icons.calendar_today))),
                    )
                    */
                  ),
                  SizedBox(
                    height: height * .2,
                  ),
                  Text("Why do we ask date of Birth",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: regular)),
                  SizedBox(
                    height: height * .1,
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  await _selectDate(context);
                  calculateAge(_selectedDate);
                  print(age);
                  if (date.text == "") {
                    AltDialog(context, "Please Enter Your BirthDate");
                  } else {
                    widget.signUpBody.age = age;
                    widget.signUpBody.dietQuestions.dOB =
                        DateFormat("yyyy-MM-dd'T'HH:mm:ss'")
                            .format(_selectedDate)
                            .toString();

                    if (widget.signUpBody.age >= 80) {
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NotSupportForPregnantOptionScreen(
                                      signUpBody: widget.signUpBody,
                                      text1: TextConstant.ageText1,
                                      text2: TextConstant.ageText2)))
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
                                        child:
                                            NotSupportForPregnantOptionScreen(
                                                signUpBody: widget.signUpBody,
                                                text1: TextConstant.ageText1,
                                                text2: TextConstant.ageText2)),
                                  )));
                    } else {
                      mobile
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DoYouHaveFollowingMedicalConditions(
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
                                        child:
                                            DoYouHaveFollowingMedicalConditions(
                                          signUpBody: widget.signUpBody,
                                        )),
                                  )));
                    }
                  }
                },
                child: Padding(
                  padding: mobile
                      ? const EdgeInsets.only(top: 20)
                      : const EdgeInsets.only(
                          top: 100, right: 30, left: 30, bottom: 30),
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

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    print("Age:-$age");
    return age;
  }
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
