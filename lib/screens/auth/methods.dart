import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Model/SignupBody.dart';
import 'package:weight_loser/Model/UserDataModel.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/AuthService.dart';
import 'package:weight_loser/Service/Local_notification.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/chatService.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/notifications/getit.dart';
import 'package:weight_loser/screens/Bottom_Navigation/bottom.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/body.dart';
import 'package:weight_loser/screens/Questions_screen/newQuestions/gender.dart';
import 'package:weight_loser/screens/Questions_screen/used-Questions/height_screen_1.dart';
import 'package:weight_loser/screens/auth/authenticate/provider/authprovider.dart';
import 'package:weight_loser/screens/auth/authenticate/provider/googleProvider.dart';
import 'package:weight_loser/screens/auth/forgot_password_screen.dart';
import 'package:weight_loser/screens/auth/methods.dart';
import 'package:weight_loser/screens/auth/signup.dart';
import 'package:weight_loser/screens/card_details/card_details_screen.dart';
import 'package:weight_loser/screens/chat/ChatBotScreen.dart';
import 'package:weight_loser/screens/choose_method.dart';
import 'package:weight_loser/screens/choose_method_test.dart';
import 'package:weight_loser/utils/ImagePath.dart';
import 'package:weight_loser/utils/Responsive.dart';
import 'package:weight_loser/utils/validation.dart';
import 'package:weight_loser/widget/SideMenu.dart';
import 'package:weight_loser/widget/SizeConfig.dart';
import 'package:weight_loser/widget/custom_form_fields.dart';

import '../../theme/TextStyles.dart';
import '../Bottom_Navigation/bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../welcome_screen/landingScreen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
SimpleFontelicoProgressDialog _dialog;
Future googleSignIn(context, _firebaseAuth, prefs) async {
  try {
    GoogleSignIn gSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await gSignIn.signIn();
    if (googleSignInAccount != null) {

      UIBlock.block(context);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
          print('$googleSignInAuthentication,gooog salfjlsdajflsjdalfjaljflsdajflsd');
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential result = await auth.signInWithCredential(credential);
      var user = result.user;
      try {
        var provider = getit<authModeprovider>();
        provider.setData(true);
        var gprovider = getit<googleprovider>();
        gprovider.setName(user.displayName);
        gprovider.setEmail(user.email);
        print("mode is fb/google:" + provider.getData().toString());
        UserDataModel _userDataModel;
        /// other user login
        otherloginUser(user.email, context, _userDataModel).then((value) {
          _userDataModel = value;
          if (_userDataModel != null && _userDataModel.status == 1) {
            ChatService.senderId = _userDataModel.user.id.toString();
            Provider.of<UserDataProvider>(context, listen: false)
                .setUserData(_userDataModel);
            AuthService.setUserId(_userDataModel.user.id);
            UIBlock.unblock(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                (route) => false);
          } else if (_userDataModel == null) {
            UIBlock.unblock(context);
            SignUpBody signupBody = SignUpBody();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LandingScreen(signUpBody: signupBody),
              ),
            );
          }
        });
      } on PlatformException catch (e) {
        UIBlock.unblock(context);
        print(e);
      } catch (e) {
        UIBlock.unblock(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  } on PlatformException catch (err) {
    print(err);
    UIBlock.unblock(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(err.toString())));
  } catch (e) {
    UIBlock.unblock(context);
    print(e);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Future facebookSignIn(
    BuildContext context, FirebaseAuth _firebaseAuth, prefs) async {
  try {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
      loginBehavior: LoginBehavior.webOnly,
    );
    switch (result.status) {
      case LoginStatus.success:
        UIBlock.block(context);
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken.token);
        await _firebaseAuth.signInWithCredential(facebookCredential);

        UserCredential result1 =
            await auth.signInWithCredential(facebookCredential);
        var user = result1.user;
        print(user);

        try {
          var provider = getit<authModeprovider>();
          provider.setData(true);
          var gprovider = getit<googleprovider>();
          gprovider.setName(user.displayName);
          gprovider.setEmail(user.email);
          print("mode is fb/google:" + provider.getData().toString());
          UserDataModel _userDataModel;
          _userDataModel =
              await otherloginUser(user.email, context, _userDataModel);

          if (_userDataModel != null && _userDataModel.status == 1) {
            ChatService.senderId = _userDataModel.user.id.toString();
            Provider.of<UserDataProvider>(context, listen: false)
                .setUserData(_userDataModel);
            AuthService.setUserId(_userDataModel.user.id);
            UIBlock.unblock(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                (route) => false);
          } else if (_userDataModel == null) {
            UIBlock.unblock(context);
            SignUpBody signupBody = SignUpBody();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LandingScreen(signUpBody: signupBody),
              ),
            );
          }
        } catch (e) {
          print(e.toString());
        }

        break;
      case LoginStatus.cancelled:
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Into Facebook Account To Continue')));
        break;
      case LoginStatus.failed:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Operation is failed')));
        break;
      case LoginStatus.operationInProgress:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Operation in progress')));
        break;
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Future<bool> hasNetwork() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    return false;
  }
}

Future<UserDataModel> otherloginUser(
    String email, context, _userDataModel) async {
  Map<String, dynamic> userdata;
  _userDataModel = null;
  print("Called _loginUser=======================");
  print("User Email:" + email);
  //UIBlock.block(context);
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Cookie':
          '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
    };
    var request = http.Request(
        'POST', Uri.parse('https://weightchoper.somee.com/api/login/other'));
    request.body = json.encode({
      "Name": email,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var resp = await response.stream.bytesToString();
    userdata = json.decode(resp);
    print(userdata);
    if (response.statusCode == 200) {
      //UIBlock.unblock(context);
      //print(userdata.entries.first);
      //if (userdata[0].Status == 1)
      _userDataModel = UserDataModel.fromJson(userdata);
      //print("UserData" + _userDataModel);
      return _userDataModel;
    } else {
      print(response.reasonPhrase);
      //UIBlock.unblock(context);
      return _userDataModel;
    }
  } catch (e) {
    print(e.toString());
    //UIBlock.unblock(context);
    return _userDataModel;
  }
}

Future<bool> signUpOtherUser(SignUpBody signUpBody, context) async {
  Map<String, dynamic> userdata = {};
  var provider = getit<googleprovider>();
  signUpBody.email = provider.getEmail();
  signUpBody.name = provider.getName();
  signUpBody.userName = provider.getName();

  // ignore: unused_field
  UserDataModel _userDataModel;
  _dialog =
      SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
  _dialog.show(
      message: "Please wait", type: SimpleFontelicoProgressDialogType.normal);
  var client = http.Client();

  try {
    var url = Uri.parse('https://weightchoper.somee.com/api/user');
    var response = await client.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Accept': '*/*',
          'User-Agent': 'PostmanRuntime/7.28.4',
          'Cookie':
              '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
        },
        body: json.encode(signUpBody.toJson()));

    print(" Signup ${response.body}");
    if (response != null && response.statusCode == 200) {
      try {
        var headers = {
          'Content-Type': 'application/json',
          'Cookie':
              '.AspNetCore.Session=CfDJ8LkC0h8Zqs5NkmTcgtyrhNkYwmRVcMK0aIUoEPn6D7IVN31IVTf7hsFfclATOj4Tmw3HVSp9PhZEGTQbVRrg1lIK%2BEqpQLkS1z0Vx6UHbwGSbu1WIpDE%2Bc3bj9Y%2BIIdmRQOOCf0OtUoqnvDebgF9UL0ulR2OsK%2BkybIsVzuab99l'
        };
        var request = http.Request('POST',
            Uri.parse('https://weightchoper.somee.com/api/login/other'));
        request.body = json.encode({
          "Name": signUpBody.email,
        });
        request.headers.addAll(headers);
        print("Sign");
        http.StreamedResponse response = await request.send();
        var resp = await response.stream.bytesToString();
        if (response.statusCode == 200) {
          print(resp.runtimeType);
          userdata = json.decode(resp);
          _userDataModel = UserDataModel.fromJson(userdata);
          final provider =
              Provider.of<UserDataProvider>(context, listen: false);
          provider.setUserData(_userDataModel);
          ChatService.senderId = _userDataModel.user.id.toString();
          print(userdata.runtimeType);
          AuthService.setUserId(_userDataModel.user.id);
          print("id ${_userDataModel.user.id}");

          _dialog.hide();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Signup  Successful",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ));

          Responsive1.isMobile(context)
              ? Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                  (route) => false)
              : Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomBarNew(0)),
                  (route) => false);
        } else {
          print(response.statusCode);
          print(response.reasonPhrase);
        }
      } catch (e) {
        print("hi");
        print(e.toString());
        //UIBlock.unblock(context);
        _dialog.hide();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User with this email already exists")));
      }
    } else {
      print(response.statusCode);
      print(response.body);
      //UIBlock.unblock(context);
      _dialog.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Signup error")));
    }
  } on SocketException catch (e) {
    print("hi2");
    print(e);
    _dialog.hide();
  } catch (e) {
    print("hi3");
    print(e.toString());
  } finally {
    client.close();
    _dialog.hide();
    //UIBlock.unblock(context);
  }
}
