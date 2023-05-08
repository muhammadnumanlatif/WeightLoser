import 'package:flutter/material.dart';
import 'package:weight_loser/mudasar/select_your_opinion_gym_rutine.dart';

class SelectYourOpinionExerciseScreen extends StatefulWidget {
  const SelectYourOpinionExerciseScreen({Key key}) : super(key: key);

  @override
  State<SelectYourOpinionExerciseScreen> createState() =>
      _SelectYourOpinionExerciseScreenState();
}

class _SelectYourOpinionExerciseScreenState
    extends State<SelectYourOpinionExerciseScreen> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    print(check);
    double height = MediaQuery.of(context).size.height - kToolbarHeight;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              SizedBox(
                  height: height * 0.1,
                  width: width,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Biology',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                            right: Radius.circular(20),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Diet',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                            right: Radius.circular(20),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Excersie',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                            right: Radius.circular(20),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Mind',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                            right: Radius.circular(20),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sleep/Habit',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      height: height * 0.01,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                            right: Radius.circular(20),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                height: height * 0.3,
                width: width,
                child: Stack(
                  children: [
                    Container(
                      height: height * 0.2,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(227, 194, 247, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Center(
                        child: Text(
                          'Let us Understand Your Profile ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: height * 0.02),
                        ),
                      ),
                    ),
                    Positioned(
                        top: height * 0.13,
                        left: height * 0.04,
                        child: Container(
                          height: height * 0.15,
                          width: width * 0.85,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Select your Daily Normal\n daily water intake",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.04),
                                  ),
                                )),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .045),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * .08,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(height * .01),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(
                              1.0,
                              1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(
                              -1.0,
                              -1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ), //BoxSh//BoxShadow
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'I can exercise more than  10 minutes \n every day',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    Container(
                      height: height * .08,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(height * .01),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(
                              1.0,
                              1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(
                              -1.0,
                              -1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ), //BoxSh//BoxShadow
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'I can exercise more than  10 minutes \n every day',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    Container(
                      height: height * .08,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(height * .01),
                        border: Border.all(color: Colors.black12, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(
                              1.0,
                              1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(
                              -1.0,
                              -1.0,
                            ),
                            blurRadius: 0.1,
                            spreadRadius: .01,
                          ), //BoxSh//BoxShadow
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'I do not know',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),

                    InkWell(
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectYourOpinionGymRutineScreen() ,));
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.6,
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                fontSize: height * 0.024,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height * 0.01,
                          width: width / 2,
                          child: LinearProgressIndicator(
                            minHeight: height * 0.02,
                            color: Colors.black,
                            value: 1.6,
                          ),
                        ),
                        const Text('60 % Completed'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}