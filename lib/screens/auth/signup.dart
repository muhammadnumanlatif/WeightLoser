import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/screens/auth/Otp_screen.dart';
import 'package:weight_loser/screens/auth/login_screen.dart';
import 'package:weight_loser/screens/auth/methods.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/utils/validation.dart';

import '../../CustomWidgets/SizeConfig.dart';
import '../../Provider/UserDataProvider.dart';
import '../../Service/AuthService.dart';
import '../../Service/Responsive.dart';
import '../../Service/chatService.dart';
import '../../constants/constant.dart';
import '../../main.dart';
import '../../notifications/getit.dart';
import '../../theme/TextStyles.dart';
import '../../utils/Responsive.dart';
import '../../utils/sizeconfig.dart';
import '../../widget/custom_form_fields.dart';
import '../Bottom_Navigation/bottom.dart';
import '../paymentScreen.dart';
import '../welcome_screen/landingScreen.dart';
import 'authenticate/provider/authprovider.dart';
import 'forgot_password_screen.dart';


/// this is ahamad class signupscreen
// class SignUpScreen extends StatefulWidget {
//   SignUpScreen();
//
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   SignUpBody signUpBody = SignUpBody();
//   SimpleFontelicoProgressDialog _dialog;
//   final form = GlobalKey<FormState>();
//   FirebaseAuth _firebaseAuth;
//   String _name = "";
//   String _email = "";
//   String _pwd = "";
//   // String _pwd2 = "";
//
//   SharedPreferences prefs;
//   Map<String, dynamic> userdata = {};
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController pas = TextEditingController();
//   // TextEditingController confirmPas = TextEditingController();
//
//   // ignore: unused_field
//   UserDataModel _userDataModel;
//
//   @override
//   void initState() {
//     super.initState();
//     _firebaseAuth = FirebaseAuth.instance;
//     // get();
//   }
//
//   Future<bool> VerifyUser(String _email) async {
//     _dialog =
//         SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
//     _dialog.show(
//         message: "Verifying User",
//         type: SimpleFontelicoProgressDialogType.normal);
//     var client = http.Client();
//
//     try {
//       var url = Uri.parse('$apiUrl/api/user/email/?Email=$_email');
//       var response = await client.get(url);
//
//       if (response != null && response.statusCode == 200) {
//         if (!response.body.contains("IsConfirmed")) {
//           _dialog.hide();
//           return true;
//         } else {
//           _dialog.hide();
//           ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("User with this email already exists")));
//         }
//       } else {
//         print(response.statusCode);
//         print(response.body);
//         _dialog.hide();
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//                 "There is a problem in sign up. Please check internet or try again")));
//       }
//     } on SocketException catch (e) {
//       print("hi2");
//       print(e);
//     } catch (e) {
//       print("hi3");
//       print(e.toString());
//     } finally {
//       client.close();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Center(
//             child: Padding(
//               padding: Responsive1.isDesktop(context)
//                   ? const EdgeInsets.only(
//                       top: 150, bottom: 100, left: 450, right: 450)
//                   : const EdgeInsets.symmetric(horizontal: 40),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10),
//                     child: Image.asset(
//                       'assets/images/weightchopper.png',
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Create Account',
//                     style: lightText18Px.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Form(
//                     key: form,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomFormFields.formFieldWithoutIcon(
//                             controller: name,
//                             hint: 'Name*',
//                             //errorText:
//                             //  Validation.validateValue(_email, 'Email', true),
//                             icon: Icon(
//                               Icons.person_outline,
//                               color: primaryColor,
//                               size: 30,
//                             ),
//                             validator: (value) {
//                               return Validation.validateValue(
//                                   _name, 'Name', false);
//                             },
//                             onChange: (val) {
//                               setState(() {
//                                 _name = val;
//                               });
//                             },
//                             onSaved: (val) {
//                               setState(() {
//                                 _name = val;
//                               });
//                             },
//                             keyboardType: TextInputType.name,
//                           ),
//                           // TextFormField(
//                           //   controller: name,
//                           //   cursorColor: Colors.grey,
//                           //   validator: (value) {
//                           //     return Validation.validateValue(
//                           //         value, 'Name', false);
//                           //   },
//                           //   onChanged: (val) {
//                           //     setState(() {
//                           //       _name = val;
//                           //     });
//                           //   },
//                           //   onSaved: (val) {
//                           //     setState(() {
//                           //       _name = val;
//                           //     });
//                           //   },
//                           //   keyboardType: TextInputType.name,
//                           //   decoration: const InputDecoration(
//                           //       focusedBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(width: .3),
//                           //       ),
//                           //       //errorText: Validation.validateValue(
//                           //       //  _name, 'Name', false),
//                           //       prefixIcon: Icon(
//                           //         Icons.person_outline,
//                           //         color: Color(0xff4885ED),
//                           //         size: 30,
//                           //       ),
//                           //       isDense: true,
//                           //       contentPadding: EdgeInsets.only(
//                           //         top: 8,
//                           //       ),
//                           //       prefixIconConstraints: BoxConstraints(
//                           //         minWidth: 35,
//                           //         minHeight: 35,
//                           //       ),
//                           //       enabledBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(width: .1),
//                           //       ),
//                           //       hintText: ' Name*',
//                           //       hintStyle: TextStyle(
//                           //           color: Colors.black38,
//                           //           fontSize: 13,
//                           //           letterSpacing: 0.3)),
//                           // ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           CustomFormFields.formFieldWithoutIcon(
//                             controller: email,
//                             hint: 'Email*',
//                             //errorText:
//                             //  Validation.validateValue(_email, 'Email', true),
//                             icon: Icon(
//                               Icons.email_outlined,
//                               color: primaryColor,
//                               size: 30,
//                             ),
//                             validator: (value) {
//                               return Validation.validateValue(
//                                   _email, 'Email', true);
//                             },
//                             onChange: (val) {
//                               setState(() {
//                                 _email = val;
//                               });
//                             },
//                             onSaved: (val) {
//                               setState(() {
//                                 _email = val;
//                               });
//                             },
//                             keyboardType: TextInputType.name,
//                           ),
//                           // TextFormField(
//                           //   controller: email,
//                           //   cursorColor: Colors.grey,
//                           //   validator: (value) {
//                           //     return Validation.validateValue(
//                           //         value, 'Email', true);
//                           //   },
//                           //   onChanged: (val) {
//                           //     setState(() {
//                           //       _email = val;
//                           //     });
//                           //   },
//                           //   onSaved: (val) {
//                           //     setState(() {
//                           //       _email = val;
//                           //     });
//                           //   },
//                           //   keyboardType: TextInputType.emailAddress,
//                           //   decoration: const InputDecoration(
//                           //       focusedBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(width: .3),
//                           //       ),
//                           //       prefixIcon: Icon(
//                           //         Icons.email_outlined,
//                           //         color: Color(0xff4885ED),
//                           //         size: 30,
//                           //       ),
//                           //       isDense: true,
//                           //       contentPadding: EdgeInsets.only(
//                           //         top: 8,
//                           //       ),
//                           //       prefixIconConstraints: BoxConstraints(
//                           //         minWidth: 35,
//                           //         minHeight: 35,
//                           //       ),
//                           //       enabledBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(width: .1),
//                           //       ),
//                           //       hintText: ' Email*',
//                           //       //errorText: Validation.validateValue(
//                           //       //  _email, 'Email', true),
//                           //       hintStyle: TextStyle(
//                           //           color: Colors.black38,
//                           //           fontSize: 13,
//                           //           letterSpacing: 0.3)),
//                           // ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           CustomFormFields.formFieldWithoutIcon(
//                             suffixIcon: isObscure
//                                 ? GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isObscure = !isObscure;
//                                       });
//                                     },
//                                     child: Icon(FontAwesomeIcons.eyeSlash))
//                                 : GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         isObscure = !isObscure;
//                                       });
//                                     },
//                                     child: const Icon(FontAwesomeIcons.eye)),
//                             isObscure: isObscure,
//                             controller: pas,
//                             hint: 'Password*',
//                             //errorText:
//                             //  Validation.validatePassword(_pwd, 'Password'),
//                             icon: const Icon(Icons.lock_open_rounded,
//                                 color: Colors.blue, size: 30),
//                             validator: (value) {
//                               return Validation.validatePassword(
//                                   _pwd, 'Password');
//                             },
//                             onChange: (val) {
//                               setState(() {
//                                 _pwd = val;
//                               });
//                             },
//                             onSaved: (val) {
//                               setState(() {
//                                 _pwd = val;
//                               });
//                             },
//                             keyboardType: TextInputType.name,
//                           ),
//                           // TextFormField(
//                           //   controller: pas,
//                           //   cursorColor: Colors.grey,
//                           //   validator: (value) {
//                           //     return Validation.validatePassword(
//                           //         value, 'Password');
//                           //   },
//                           //   onChanged: (val) {
//                           //     setState(() {
//                           //       _pwd = val;
//                           //     });
//                           //   },
//                           //   onSaved: (val) {
//                           //     setState(() {
//                           //       _pwd = val;
//                           //     });
//                           //   },
//                           //   keyboardType: TextInputType.visiblePassword,
//                           //   decoration: const InputDecoration(
//                           //       focusedBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(width: .3),
//                           //       ),
//                           //       prefixIcon: Icon(
//                           //         Icons.lock_open_rounded,
//                           //         color: Color(0xff4885ED),
//                           //         size: 30,
//                           //       ),
//                           //       isDense: true,
//                           //       contentPadding: EdgeInsets.only(
//                           //         top: 8,
//                           //       ),
//                           //       prefixIconConstraints: BoxConstraints(
//                           //         minWidth: 35,
//                           //         minHeight: 35,
//                           //       ),
//                           //       enabledBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(width: .1),
//                           //       ),
//                           //       hintText: ' Password*',
//                           //       //errorText: Validation.validatePassword(
//                           //       //  _pwd, 'Password'),
//                           //       hintStyle: TextStyle(
//                           //           color: Colors.black38,
//                           //           fontSize: 13,
//                           //           letterSpacing: 0.3)),
//                           // ),
//                           // const SizedBox(
//                           //   height: 30,
//                           // ),
//                           // TextFormField(
//                           //   controller: confirmPas,
//                           //   cursorColor: Colors.grey,
//                           //   validator: (value) {
//                           //     return Validation.validatePassword(
//                           //         _pwd2, "Confirm Password", true, _pwd);
//                           //   },
//                           //   onChanged: (val) {
//                           //     setState(() {
//                           //       _pwd2 = val;
//                           //     });
//                           //   },
//                           //   onSaved: (val) {
//                           //     setState(() {
//                           //       _pwd2 = val;
//                           //     });
//                           //   },
//                           //   keyboardType: TextInputType.visiblePassword,
//                           //   decoration: const InputDecoration(
//                           //       focusedBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(width: .3),
//                           //       ),
//                           //       prefixIcon: Icon(
//                           //         Icons.lock_outline,
//                           //         color: Color(0xff4885ED),
//                           //         size: 30,
//                           //       ),
//                           //       isDense: true,
//                           //       contentPadding: EdgeInsets.only(
//                           //         top: 8,
//                           //       ),
//                           //       prefixIconConstraints: BoxConstraints(
//                           //         minWidth: 35,
//                           //         minHeight: 35,
//                           //       ),
//                           //       enabledBorder: UnderlineInputBorder(
//                           //         borderSide: BorderSide(width: .1),
//                           //       ),
//                           //       hintText: ' Confirm Password*',
//                           //       //errorText: Validation.validatePassword(
//                           //       //  _pwd2, "Confirm Password", true, _pwd),
//                           //       hintStyle: TextStyle(
//                           //           color: Colors.black38,
//                           //           fontSize: 13,
//                           //           letterSpacing: 0.3)),
//                           // ),
//                           const SizedBox(
//                             height: 40,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Get.to(() => LoginScreen());
//                                   },
//                                   child: Transform.translate(
//                                     offset: const Offset(0, -2.5),
//                                     child: const Text(
//                                       'Already member?',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           color: Color(0xff4885ED),
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     /*
//                                 if (_pwd.isNotEmpty &&
//                                   _pwd2.isNotEmpty &&
//                                   _pwd == _pwd2)
//                                   */
//                                     final FormState formState =
//                                         form.currentState;
//
//                                     if (formState.validate()) {
//                                       var provider = getit<authModeprovider>();
//                                       provider.setData(false);
//                                       signUpBody.userName = _name;
//                                       signUpBody.name = _name;
//                                       signUpBody.email = _email;
//                                       signUpBody.password = _pwd;
//                                       var datetime = DateTime.now();
//                                       //var datetime = "2022-06-21T12:22:47259Z";
//                                       SignUpRequestModel requestModel =
//                                           SignUpRequestModel(
//                                               userName: _name,
//                                               name: _name,
//                                               email: _email,
//                                               password: _pwd,
//                                               UserDateTime:
//                                                   datetime.toIso8601String());
//
//                                       ///* verify email API Call
//                                       VerifyUser(_email).then((value) {
//                                         if (value) {
//                                           /* Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => AboutUs(
//                                                 signUpBody: signUpBody)));*/
//
//                                           // signUpUser(signUpBody).then((value) {
//                                           //
//                                           // });
//
//                                           ///* Send OTP API Call
//                                           sendOtp(signUpBody.email, context)
//                                               .then((value) {
//                                             if (value) {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           OTPScreen(
//                                                             email: signUpBody
//                                                                 .email,
//                                                             text:
//                                                                 'SignupFirstPage',
//                                                             signUpBody:
//                                                                 signUpBody,
//                                                             signUpRequestModel:
//                                                                 requestModel,
//                                                             userDataModel:
//                                                                 _userDataModel,
//                                                           )));
//                                             }
//                                           });
//                                         }
//                                       });
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(const SnackBar(
//                                         content: Text(
//                                             "Please fill the required information"),
//                                         backgroundColor: Colors.red,
//                                       ));
//                                     }
//                                   },
//                                   child: Container(
//                                     height: 30,
//                                     width: 100,
//                                     decoration: BoxDecoration(
//                                         color: Color(0xff4885ED),
//                                         border: Border.all(
//                                             color: Colors.grey, width: 1),
//                                         borderRadius: const BorderRadius.all(
//                                             Radius.circular(15))),
//                                     child: const Center(
//                                       child: Text(
//                                         'Sign Up',
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 16),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Center(
//                           //   child: const Text(
//                           //     'Already a member?',
//                           //     style: TextStyle(
//                           //         fontSize: 13, fontWeight: FontWeight.w400),
//                           //   ),
//                           // ),
//                           // const SizedBox(
//                           //   height: 20,
//                           // ),
//                           // Center(
//                           //   child: GestureDetector(
//                           //     onTap: () {
//                           //       Get.to(() => LoginScreen());
//                           //     },
//                           //     child: const Text(
//                           //       'Login',
//                           //       style: TextStyle(
//                           //           fontSize: 15,
//                           //           color: Color(0xff4885ED),
//                           //           fontWeight: FontWeight.w700),
//                           //     ),
//                           //   ),
//                           // ),
//                           // const SizedBox(
//                           //   height: 15,
//                           // ),
//                           // const Center(
//                           //   child: Text(
//                           //     'or connect with',
//                           //     style: TextStyle(
//                           //         fontSize: 13, fontWeight: FontWeight.w700),
//                           //   ),
//                           // ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 30),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 InkWell(
//                                   onTap: () async {
//                                     bool isOnline = await hasNetwork();
//                                     if (isOnline) {
//                                       if (_firebaseAuth.currentUser == null) {
//                                         await facebookSignIn(
//                                             context, _firebaseAuth, prefs);
//                                       } else {
//                                         await _firebaseAuth.signOut();
//                                         await facebookSignIn(
//                                             context, _firebaseAuth, prefs);
//                                       }
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(const SnackBar(
//                                               content: Text(
//                                                   'Check internet connection')));
//                                     }
//                                   },
//                                   child: Container(
//                                     width: 60,
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.2),
//                                           spreadRadius: 2,
//                                           blurRadius: 5,
//                                           offset: const Offset(
//                                             0,
//                                             4,
//                                           ), // changes position of shadow
//                                         ),
//                                       ],
//                                       shape: BoxShape.circle,
//                                       // borderRadius:
//                                       //     BorderRadius.all(Radius.circular(40))
//                                     ),
//                                     //margin: EdgeInsets.only(right: 8, top: 8),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(15.0),
//                                       child: Image.asset(
//                                         ImagePath.facebook,
//                                         height: 30,
//                                         width: 30,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 //if (Platform.isAndroid)
//
//                                 InkWell(
//                                   onTap: () async {
//                                     bool isOnline = await hasNetwork();
//                                     if (isOnline) {
//                                       if (_firebaseAuth.currentUser == null) {
//                                         await googleSignIn(
//                                             context, _firebaseAuth, prefs);
//                                       } else {
//                                         await _firebaseAuth.signOut();
//                                         await googleSignIn(
//                                             context, _firebaseAuth, prefs);
//                                       }
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(const SnackBar(
//                                               content: Text(
//                                                   'Check internet connection')));
//                                     }
//                                   },
//                                   child: Container(
//                                     width: 60,
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.2),
//                                           spreadRadius: 2,
//                                           blurRadius: 5,
//                                           offset: const Offset(
//                                             0,
//                                             4,
//                                           ), // changes position of shadow
//                                         ),
//                                       ],
//                                       shape: BoxShape.circle,
//                                       // borderRadius:
//                                       //     BorderRadius.all(Radius.circular(40))
//                                     ),
//                                     //margin: EdgeInsets.only(right: 8, top: 8),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(15.0),
//                                       child: Image.asset(
//                                         ImagePath.google,
//                                         height: 30,
//                                         width: 30,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 if (Platform.isIOS)
//                                   InkWell(
//                                     onTap: () {
//                                       // Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(
//                                       //       builder: (context) =>
//                                       //           CardDetailScreen()),
//                                       // );
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(const SnackBar(
//                                               content:
//                                                   Text('Not Integrated Yet.')));
//                                     },
//                                     child: Container(
//                                       width: 60,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 5,
//                                             offset: const Offset(
//                                               0,
//                                               4,
//                                             ), // changes position of shadow
//                                           ),
//                                         ],
//                                         shape: BoxShape.circle,
//                                         // borderRadius:
//                                         //     BorderRadius.all(Radius.circular(40))
//                                       ),
//                                       //margin: EdgeInsets.only(right: 8, top: 8),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(15.0),
//                                         child: Image.asset(
//                                           ImagePath.apple,
//                                           height: 30,
//                                           width: 30,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<bool> sendOtp(String email, context) async {
//     _dialog =
//         SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
//     _dialog.show(
//       message: "Sending Verification Code",
//       type: SimpleFontelicoProgressDialogType.normal,
//       height: 125,
//       width: 200,
//     );
//     var requestBody = {'email': email};
//     final response = await post(
//       Uri.parse('$apiUrl/api/login/EmailVerify'),
//       body: requestBody,
//     );
//     if (response.statusCode == 200) {
//       _dialog.hide();
//       return true;
//       //json.encode(response.body);
//     } else {
//       _dialog.hide();
//       throw Exception('unable to find your email');
//     }
//   }
//
//   Future createfirebaseAccount(String email, String password) async {
//     FirebaseAuth _auth = FirebaseAuth.instance;
//
//     try {
//       UserCredential userCrendetial = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       return userCrendetial.user;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
// }

/// this is mudasar  ui calss

class SignUpScreen extends StatefulWidget {
  SignUpScreen();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

bool isObscure = true;

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuth _firebaseAuth;
  SharedPreferences prefs;
  String _email = '';
  String _pwd = '';
  double heigh;
  double width;

  @override
  void initState() {
    // _emailController.text = "Shabby123";
    // _passwordController.text = "12354555";
    // _emailController.text = "Abhi@gmail.com";
    // _passwordController.text = "123123";
    // _emailController.text="pranav1@gmail.com";
    // _passwordController.text="56789";
    // _emailController.text="omnivore@test.com";
    // _passwordController.text="123123123";
    _emailController.text = "";
    _passwordController.text = "";
    // _emailController.text="alergi@test.com";
    // _passwordController.text="123123123";
    // _emailController.text="newu@gmail.com";
    // _passwordController.text="123123123";
    // _emailController.text="test@test547.com";
    // _passwordController.text="12345678";
    // _emailController.text="Kairav@gmail.com";
    // _passwordController.text="123456";
    _firebaseAuth = FirebaseAuth.instance;
    super.initState();

    //   var androidSettings = AndroidInitializationSettings('app_icon');
    //   var iOSSettings = IOSInitializationSettings(
    //     requestSoundPermission: false,
    //     requestBadgePermission: false,
    //     requestAlertPermission: false,
    //   );
    //   var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    //   flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onClickNotification);
    // }
    // Future onClickNotification(String payload) {
    //   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //     return BottomBarNew(
    //       0
    //     );
    //   }));
  }

  /*
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
  }
  */

  final form = GlobalKey<FormState>();

  Map<String, dynamic> userdata;

  // ignore: unused_field
  UserDataModel _userDataModel;

  // ignore: unused_element
  Future firebaselogIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim().toString(),
          password: _passwordController.text.trim().toString());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> _loginUser() async {
    UIBlock.block(context);
    await firebaselogIn();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Cookie':
            '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
      };
      var request = http.Request(
          'POST', Uri.parse('https://weightchoper.somee.com/api/login'));
      request.body = json.encode({
        "Name": "${_emailController.text}",
        "Password": "${_passwordController.text}"
      });
      request.headers.addAll(headers);

      logger.e("Login Request Body :" + request.toString());
      http.StreamedResponse response = await request.send();
      var resp = await response.stream.bytesToString();

      logger.e("Login Response :" + resp.toString());
      if (response.statusCode == 200) {
        UIBlock.unblock(context);
        userdata = json.decode(resp);
        _userDataModel = UserDataModel.fromJson(userdata);
        if (_userDataModel.responseDto.status) {
          final provider =
              Provider.of<UserDataProvider>(context, listen: false);
          provider.setUserData(_userDataModel);
          ChatService.senderId = _userDataModel.user.id.toString();
          print(userdata.runtimeType);
          AuthService.setUserId(_userDataModel.user.id);
          print(_userDataModel.user.id);
          return true;
        } else {
          return false;
        }
      } else {
        print(response.reasonPhrase);
        //UIBlock.unblock(context);
        return false;
      }
    } catch (e) {
      print(e.toString());
      //UIBlock.unblock(context);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    heigh = MediaQuery.of(context).size.height - kToolbarHeight;
    width = MediaQuery.of(context).size.width;

    MySize().init(context);
    SizeConfig().init(context);
    Responsive().setContext(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: heigh * 0.04,
                    ),
                    SizedBox(
                      height: 0.06,
                      width: width,
                      child: Image.asset(
                        'assets/images/weightchopper.png',
                      ),
                    ),
                    SizedBox(height: heigh * 0.05),
                    Text(
                      'Getting Started',
                      style: TextStyle(
                          fontSize: heigh * 0.04, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: heigh * 0.04),
                    Text(
                      'Promotion Line, Action Line',
                      style: lightText18Px.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 19),
                    ),
                    SizedBox(height: heigh * 0.08),
                    // Name TextFormField
                    CustomFormFields.formFieldWithoutIcon(
                      controller: _emailController,
                      hint: 'YourName*',
                      errorText:
                      Validation.validateValue(_email, 'Name', true),
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black38,
                        size: 30,
                      ),
                      validator: (value) {
                        return Validation.validateValue(value, 'Name', true);
                      },
                      onChange: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                      onSaved: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: heigh * 0.02),
                    // Email TextFormFeild
                    CustomFormFields.formFieldWithoutIcon(
                      controller: _emailController,
                      hint: 'Email*',
                      errorText:
                          Validation.validateValue(_email, 'Email', true),
                      icon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black38,
                        size: 30,
                      ),
                      validator: (value) {
                        return Validation.validateValue(value, 'Email', true);
                      },
                      onChange: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                      onSaved: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: heigh * 0.02),
                    // this is password formField
                    CustomFormFields.formFieldWithoutIcon(
                      suffixIcon: isObscure
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              child: const Icon(FontAwesomeIcons.eyeSlash))
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              child: const Icon(FontAwesomeIcons.eye)),
                      isObscure: isObscure,
                      controller: _passwordController,
                      hint: 'Password*',
                      errorText: Validation.validatePassword(_pwd, 'Password'),
                      icon: const Icon(Icons.lock_open_rounded,
                          color: Colors.black38, size: 30),
                      validator: (value) {
                        return Validation.validatePassword(value, 'Password');
                      },
                      onChange: (val) {
                        setState(() {
                          _pwd = val;
                        });
                      },
                      onSaved: (val) {
                        setState(() {
                          _pwd = val;
                        });
                      },
                      keyboardType: TextInputType.name,
                    ),
                    // forget passwor text Field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ForgotPasswordScreen());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ForgotPasswordScreen();
                            }));
                          },
                          child: Text(
                            'Forgot password? ',
                            style: TextStyle(
                                color: Colors.blue, fontSize: heigh * 0.02),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigh * 0.02),
                    /// this is login button
                    _loginButton(),
                    SizedBox(height: heigh * 0.02),
                    /// do you have and account field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(fontSize: heigh * 0.02),
                            ),
                            InkWell(
                              onTap: () {
                                /// do sign up page
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: heigh * 0.02),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: heigh * 0.04),

                    ///  or text field
                    _orContanerText(),
                    SizedBox(height: heigh * 0.05),

                    /// google and facebook button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// signInWithGoogle
                        _googleSignInButton(),

                        /// signinWithFacebookAndGoogle
                        _facebookSignInButton(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        final FormState formState = form.currentState;
        //if (_emailController.text.isEmpty ||
        //  _passwordController.text.isEmpty)
        if (!formState.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please fill the required information"),
            backgroundColor: Colors.red,
          ));
          return;
        } else {
          ChatService.senderId = _emailController.text;
          _loginUser().then((value) {
            if (value) {
              print("SignUp");
              Provider.of<UserDataProvider>(context, listen: false)
                  .setUserData(_userDataModel);
              AuthService.setQuestionOrder(_userDataModel.user.QuestionOrder);
              AuthService.setPaid(_userDataModel.Paid);

              SignUpBody signupBody = SignUpBody();
              if (_userDataModel.user.QuestionOrder == 23) {
                if (_userDataModel.Paid) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PaymentScreen()));
                }
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LandingScreen(
                      signUpBody: signupBody,
                      userModel: _userDataModel,
                    ),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Email or Password Incorrect"),
                backgroundColor: Colors.red,
              ));
            }
          }).onError((error, stackTrace) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Error 404")));
          });
        }
      },
      child: Container(
        height: heigh * 0.065,
        width: width * 0.8,
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: Text(
            'Log in',
            style: TextStyle(color: Colors.white, fontSize: heigh * 0.02),
          ),
        ),
      ),
    );
  }

  Widget signinWithFacebookAndGoogle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: Container(
            width: width * 0.4,
            height: heigh * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(
                    0,
                    4,
                  ), // changes position of shadow
                ),
              ],
              shape: BoxShape.circle,
// borderRadius:
//     BorderRadius.all(Radius.circular(40))
            ),
//margin: EdgeInsets.only(right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    ImagePath.facebook,
                    height: 30,
                    width: 30,
                  ),
                ),
                const Text(
                  'Facebooke',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
//if (Platform.isAndroid)
        /// thiis is google signin
        InkWell(
          onTap: () async {
            bool isOnline = await hasNetwork();
            if (isOnline) {
              if (_firebaseAuth.currentUser == null) {
                await googleSignIn(context, _firebaseAuth, prefs);
              } else {
                await _firebaseAuth.signOut();
                await googleSignIn(context, _firebaseAuth, prefs);
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Check internet connection')));
            }
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(
                    0,
                    4,
                  ), // changes position of shadow
                ),
              ],
              shape: BoxShape.circle,
              // borderRadius:
              //     BorderRadius.all(Radius.circular(40))
            ),
            //margin: EdgeInsets.only(right: 8, top: 8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                ImagePath.google,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ),
        //if (Platform.isIOS)
        InkWell(
          onTap: () {
// Navigator.push(
//   context,
//   MaterialPageRoute(
//       builder: (context) =>
//           CardDetailScreen()),
// );
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Not Integrated Yet.')));
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(
                    0,
                    4,
                  ), // changes position of shadow
                ),
              ],
              shape: BoxShape.circle,
// borderRadius:
//     BorderRadius.all(Radius.circular(40))
            ),
//margin: EdgeInsets.only(right: 8, top: 8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                ImagePath.apple,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// this is sign in with facebooke
  Widget _facebookSignInButton() {
    return InkWell(
      onTap: () async {
        bool isOnline = await hasNetwork();
        if (isOnline) {
          if (_firebaseAuth.currentUser == null) {
            await facebookSignIn(context, _firebaseAuth, prefs);
          } else {
            await _firebaseAuth.signOut();
            await facebookSignIn(context, _firebaseAuth, prefs);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Check internet connection'),
            ),
          );
        }
      },
      child: Container(
        width: width * 0.4,
        height: heigh * 0.065,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                0,
                4,
              ), // changes position of shadow
            ),
          ],

          // borderRadius:
          //     BorderRadius.all(Radius.circular(40))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(),
            SizedBox(
              height: heigh * 0.04,
              child: Image.asset(
                ImagePath.facebook,
                height: 30,
                width: 30,
              ),
            ),
            Text(
              'Facebook',
              style: TextStyle(
                  fontSize: heigh * 0.02,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  /// this is sign in with google
  Widget _googleSignInButton() {
    return InkWell(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LScreen(),));
        // bool isOnline = await hasNetwork();
        // if (isOnline) {
        //   if (_firebaseAuth.currentUser == null) {
        //     print(
        //         "${_firebaseAuth.currentUser}@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        //     await googleSignIn(context, _firebaseAuth, prefs);
        //   } else {
        //     await _firebaseAuth.signOut();
        //     await googleSignIn(context, _firebaseAuth, prefs);
        //   }
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('Check internet connection')));
        // }
      },
      child: Container(
        width: width * 0.4,
        height: heigh * 0.065,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(
                0,
                4,
              ), // changes position of shadow
            ),
          ],

          // borderRadius:
          //     BorderRadius.all(Radius.circular(40))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(),
            SizedBox(
              height: heigh * 0.04,
              child: Image.asset(
                ImagePath.google,
                height: 30,
                width: 30,
              ),
            ),
            Text(
              'Google',
              style: TextStyle(
                  fontSize: heigh * 0.02, fontWeight: FontWeight.w600),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  /// this is or container text widget
  Widget _orContanerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: heigh * 0.002,
          width: width * 0.38,
          decoration: BoxDecoration(color: Colors.black12),
        ),
        FittedBox(child: Text('  or  ')),
        Container(
          height: heigh * 0.002,
          width: width * 0.38,
          decoration: BoxDecoration(color: Colors.black12),
        )
      ],
    );
  }

  Future<String> signInWithGoogle() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>LScreen() ,));
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    //
    // final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    // final GoogleSignInAuthentication googleSignInAuthentication =
    //     await googleSignInAccount.authentication;
    //
    // final AuthCredential credential = GoogleAuthProvider.credential(
    //   accessToken: googleSignInAuthentication.accessToken,
    //   idToken: googleSignInAuthentication.idToken,
    // );
    //
    // final authResult = await _auth.signInWithCredential(credential);
    // final User user = authResult.user;
    //
    // assert(!user.isAnonymous);
    // assert(await user.getIdToken() != null);
    //
    // final User currentUser = await _auth.currentUser;
    // assert(user.uid == currentUser.uid);
    //
    // return 'signInWithGoogle succeeded: $user';
  }

  Widget _checkGoogleSignIn() {
    return ElevatedButton(
        onPressed: () async {
          await signInWithGoogle();
        },
        child: Text('this is foo signIn Google '));
  }
}
