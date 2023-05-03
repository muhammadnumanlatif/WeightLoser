// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    this.name,
    this.password,
    this.user,
    this.profileVM,
    this.keyToken,
    this.message,
    this.status,
    this.Paid,
    this.responseDto,
  });

  String name;
  int status;
  bool Paid;
  dynamic password;
  UserLocal user;
  ProfileVMModel profileVM;
  String keyToken;
  dynamic message;
  ResponseDto responseDto;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
      name: json["Name"],
      password: json["Password"],
      user: UserLocal.fromJson(json["user"]),
      profileVM: ProfileVMModel.fromJson(json["profileVM"]),
      keyToken: json["keyToken"],
      message: json["Message"],
      responseDto: ResponseDto.fromJson(json["responseDto"]),
      status: json['Status'],
      Paid: json['Paid']);

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Password": password,
        "user": user.toJson(),
        "profileVM": profileVM.toJson(),
        "keyToken": keyToken,
        "Message": message,
        "Status": status,
        "responseDto": responseDto.toJson(),
      };
}

class ResponseDto {
  ResponseDto({
    this.status,
    this.message,
    this.exception,
  });

  bool status;
  String message;
  dynamic exception;

  factory ResponseDto.fromJson(Map<String, dynamic> json) => ResponseDto(
        status: json["Status"],
        message: json["Message"],
        exception: json["Exception"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Exception": exception,
      };
}

class UserLocal {
  UserLocal({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.otp,
    this.isConfirmed,
    this.QuestionOrder,
    this.createdAt,
    this.modifiedAt,
  });

  int id;
  String userName;
  String email;
  String password;
  bool otp;
  bool isConfirmed;
  int QuestionOrder;
  DateTime createdAt;
  dynamic modifiedAt;

  // "Id": 104,
  // "UserName": "faizan ",
  // "Email": "faizanshoukat45@gmail.com",
  // "Password": "admin123",
  // "Token": null,
  // "Type": "app",
  // "OTP": false,
  // "IsConfirmed": false,
  // "TimeDiff": 4.98,
  // "QuestionOrder": 23,
  // "CreatedAt": "2023-01-25T03:09:04.37",
  // "ModifiedAt": null

  factory UserLocal.fromJson(Map<String, dynamic> json) => UserLocal(
        id: json["Id"],
        userName: json["UserName"],
        email: json["Email"],
        password: json["Password"],
        otp: json["OTP"],
        isConfirmed: json["IsConfirmed"],
        QuestionOrder: json["QuestionOrder"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        modifiedAt: json["ModifiedAt"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "Email": email,
        "Password": password,
        "OTP": otp,
        "IsConfirmed": isConfirmed,
        "QuestionOrder": QuestionOrder,
        "CreatedAt": createdAt.toIso8601String(),
        "ModifiedAt": modifiedAt,
      };
}

class ProfileVMModel {
  int userId;
  String userName;
  String email;
  String userPassword;
  bool isConfirmed;
  bool iVR;
  String name;
  String dOB;
  Null country;
  int targetCal;
  int weight;
  int currentweight;
  int startWeight;
  int goalWeight;
  Null weighingDay;
  String fileName;
  int activityLevel;
  int goalId;
  int targetCalId;
  int profileId;
  int zipCode;
  int age;
  String gender;
  Null mobile;
  double height;
  Null callDuration;
  String joiningDate;
  Null imageFile;
  Null responseDto;
  int planId;
  Null type;
  Null planName;
  Null planImage;
  Null cuisine;
  Null restrictedFood;
  Null streakLevel;
  String weightUnit;
  String heightUnit;
  String redeemStatus;
  int questionOrder;
  int totalFavCuisines;

  ProfileVMModel(
      {this.userId,
      this.userName,
      this.email,
      this.userPassword,
      this.isConfirmed,
      this.iVR,
      this.name,
      this.dOB,
      this.country,
      this.targetCal,
      this.weight,
      this.currentweight,
      this.startWeight,
      this.goalWeight,
      this.weighingDay,
      this.fileName,
      this.activityLevel,
      this.goalId,
      this.targetCalId,
      this.profileId,
      this.zipCode,
      this.age,
      this.gender,
      this.mobile,
      this.height,
      this.callDuration,
      this.joiningDate,
      this.imageFile,
      this.responseDto,
      this.planId,
      this.type,
      this.planName,
      this.planImage,
      this.cuisine,
      this.restrictedFood,
      this.streakLevel,
      this.weightUnit,
      this.heightUnit,
      this.redeemStatus,
      this.questionOrder,
      this.totalFavCuisines});

  ProfileVMModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['UserName'];
    email = json['Email'];
    userPassword = json['UserPassword'];
    isConfirmed = json['IsConfirmed'];
    iVR = json['IVR'];
    name = json['Name'];
    dOB = json['DOB'];
    country = json['Country'];
    targetCal = json['target_Cal'];
    weight = json['Weight'];
    currentweight = json['Currentweight'];
    startWeight = json['StartWeight'];
    goalWeight = json['GoalWeight'];
    weighingDay = json['WeighingDay'];
    fileName = json['FileName'];
    activityLevel = json['ActivityLevel'];
    goalId = json['goal_Id'];
    targetCalId = json['target_cal_Id'];
    profileId = json['profile_Id'];
    zipCode = json['ZipCode'];
    age = json['Age'];
    gender = json['Gender'];
    mobile = json['Mobile'];
    height = json['Height'].toDouble();
    callDuration = json['CallDuration'];
    joiningDate = json['JoiningDate'];
    imageFile = json['ImageFile'];
    responseDto = json['responseDto'];
    planId = json['PlanId'];
    type = json['Type'];
    planName = json['PlanName'];
    planImage = json['PlanImage'];
    cuisine = json['Cuisine'];
    restrictedFood = json['RestrictedFood'];
    streakLevel = json['StreakLevel'];
    weightUnit = json['WeightUnit'];
    heightUnit = json['HeightUnit'];
    redeemStatus = json['RedeemStatus'];
    questionOrder = json['QuestionOrder'];
    totalFavCuisines = json['TotalFavCuisines'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['UserName'] = this.userName;
    data['Email'] = this.email;
    data['UserPassword'] = this.userPassword;
    data['IsConfirmed'] = this.isConfirmed;
    data['IVR'] = this.iVR;
    data['Name'] = this.name;
    data['DOB'] = this.dOB;
    data['Country'] = this.country;
    data['target_Cal'] = this.targetCal;
    data['Weight'] = this.weight;
    data['Currentweight'] = this.currentweight;
    data['StartWeight'] = this.startWeight;
    data['GoalWeight'] = this.goalWeight;
    data['WeighingDay'] = this.weighingDay;
    data['FileName'] = this.fileName;
    data['ActivityLevel'] = this.activityLevel;
    data['goal_Id'] = this.goalId;
    data['target_cal_Id'] = this.targetCalId;
    data['profile_Id'] = this.profileId;
    data['ZipCode'] = this.zipCode;
    data['Age'] = this.age;
    data['Gender'] = this.gender;
    data['Mobile'] = this.mobile;
    data['Height'] = this.height;
    data['CallDuration'] = this.callDuration;
    data['JoiningDate'] = this.joiningDate;
    data['ImageFile'] = this.imageFile;
    data['responseDto'] = this.responseDto;
    data['PlanId'] = this.planId;
    data['Type'] = this.type;
    data['PlanName'] = this.planName;
    data['PlanImage'] = this.planImage;
    data['Cuisine'] = this.cuisine;
    data['RestrictedFood'] = this.restrictedFood;
    data['StreakLevel'] = this.streakLevel;
    data['WeightUnit'] = this.weightUnit;
    data['HeightUnit'] = this.heightUnit;
    data['RedeemStatus'] = this.redeemStatus;
    data['QuestionOrder'] = this.questionOrder;
    data['TotalFavCuisines'] = this.totalFavCuisines;
    return data;
  }
}
