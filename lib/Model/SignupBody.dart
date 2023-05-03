import 'package:weight_loser/Model/customer_pkgs.dart';
import 'package:weight_loser/Model/rest_id.dart';
import 'dart:convert' show JSON;
import 'customer_pkgs.dart';

class SignUpBody {
  String userName;
  String email;
  String password;
  String name;
  int age;
  DietQuestions dietQuestions;
  List<RestId> restaurants;
  MindQuestions mindQuestions;
  ExerciseQuestions exerciseQuestions;
  CustomerPackages customerPackages;
  String facebookToken;
  String googleToken;
  String appleToken;

  SignUpBody(
      {this.userName,
      this.email,
      this.password,
      this.name,
      this.age,
      this.restaurants,
      this.dietQuestions,
      this.mindQuestions,
      this.exerciseQuestions,
      this.customerPackages,
      this.appleToken,
      this.facebookToken,
      this.googleToken});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    email = json['Email'];
    password = json['Password'];
    name = json['Name'];
    var resId = json['restaurants'];
    restaurants = resId.cast<RestId>() != null ? resId.cast<RestId>() : [];
    age = json['Age'];
    customerPackages = json['customerPackages'] != null
        ? new CustomerPackages.fromJson(json['customerPackages'])
        : "";
    exerciseQuestions = json['exerciseQuestions'] != null
        ? new ExerciseQuestions.fromJson(json['exerciseQuestions'])
        : "";
    dietQuestions = json['dietQuestions'] != null
        ? new DietQuestions.fromJson(json['dietQuestions'])
        : "";
    mindQuestions = json['mindQuestions'] != null
        ? new MindQuestions.fromJson(json['mindQuestions'])
        : "";
    facebookToken = json['facebookToken'];
    googleToken = json['googleToken'];
    appleToken = json['appleToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Name'] = this.name;
    data['Age'] = this.age;
    if (this.customerPackages != null) {
      data['customerPackages'] = this.customerPackages.toJson();
    }
    if (this.dietQuestions != null) {
      data['dietQuestions'] = this.dietQuestions.toJson();
    }
    data['restaurants'] = this.restaurants;
    if (this.mindQuestions != null) {
      data['mindQuestions'] = this.mindQuestions.toJson();
    }
    if (this.exerciseQuestions != null) {
      data['exerciseQuestions'] = this.exerciseQuestions.toJson();
    }
    data['facebookToken'] = this.facebookToken;
    data['googleToken'] = this.googleToken;
    data['appleToken'] = this.appleToken;
    return data;
  }
}

class SignUpRequestModel {
  String userName;
  String email;
  String password;
  String name;
  String UserDateTime;

  SignUpRequestModel(
      {this.userName,
        this.email,
        this.password,
        this.name,
         this.UserDateTime
});

  SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    email = json['Email'];
    password = json['Password'];
    name = json['Name'];
    //UserDateTime=DateTime.tryParse(json['UserDateTime']);
     UserDateTime=json['UserDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Name'] = this.name;
     data['UserDateTime']=this.UserDateTime;

    return data;
  }
}


dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}

class DietQuestions {
  double height;
  String heightUnit;
  int currentWeight;
  String weightUnit;
  int goalWeight;
  String duration;
  String gender;
  String dOB;
  int sleepTime;
  String favCuisine;
  String noCuisine;
  String favRestuarant;
  String favFoods;
  String restrictedFood;
  String medicalCondition;
  String lifeStyle;
  String weightApps;
  String foodType;
  String allergies;
  DietQuestions(
      {this.height,
      this.heightUnit,
      this.currentWeight,
      this.weightUnit,
      this.goalWeight,
      this.duration,
      this.gender,
      this.dOB,
      this.sleepTime,
      this.favCuisine,
      this.noCuisine,
      this.favRestuarant,
      this.favFoods,
      this.restrictedFood,
      this.medicalCondition,
      this.lifeStyle,
      this.weightApps,
      this.allergies,
      this.foodType});

  DietQuestions.fromJson(Map<String, dynamic> json) {
    height = json['Height'] != null ? json['Height'] : 0.0;
    heightUnit = json['HeightUnit'] != null ? json['HeightUnit'] : "";
    currentWeight = json['CurrentWeight'];
    weightUnit = json['WeightUnit'];
    goalWeight = json['GoalWeight'];
    duration = json['Duration'];
    gender = json['Gender'];
    dOB = json['DOB'];
    // JSON.encode(json['DOB'], toEncodable: myEncode);

    sleepTime = json['SleepTime'];
    favCuisine = json['FavCuisine'];
    noCuisine = json['NoCuisine'];
    favRestuarant = json['FavRestuarant'];
    favFoods = json['FavFoods'];
    restrictedFood = json['RestrictedFood'];
    medicalCondition = json['MedicalCondition'];
    lifeStyle = json['LifeStyle'];
    weightApps = json['WeightApps'];
    foodType = json['FoodType'];
    allergies = json['Allergies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Height'] = this.height;
    data['HeightUnit'] = this.heightUnit;
    data['CurrentWeight'] = this.currentWeight;
    data['WeightUnit'] = this.weightUnit;
    data['GoalWeight'] = this.goalWeight;
    data['Duration'] = this.duration;
    data['Gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['SleepTime'] = this.sleepTime;
    data['FavCuisine'] = this.favCuisine;
    data['NoCuisine'] = this.noCuisine;
    data['FavRestuarant'] = this.favRestuarant;
    data['FavFoods'] = this.favFoods;
    data['RestrictedFood'] = this.restrictedFood;
    data['MedicalCondition'] = this.medicalCondition;
    data['LifeStyle'] = this.lifeStyle;
    data['WeightApps'] = this.weightApps;
    data['FoodType'] = this.foodType;
    data['Allergies'] = this.allergies;
    return data;
  }
}

class MindQuestions {
  String control;
  String preoccupied;
  String freeFood;
  String eatingRound;
  String cravings;
  String craveFoods;
  String stressedEating;
  String sadEating;
  String boredEating;
  String lonelyEating;
  String dailyEating;
  String sevenSleeping;
  String largeEating;
  String watchingEating;
  String freeTimeEating;
  String waterHabit;
  String lateNightHabit;
  String category;
  MindQuestions(
      {this.control,
      this.preoccupied,
      this.freeFood,
      this.eatingRound,
      this.cravings,
      this.craveFoods,
      this.stressedEating,
      this.sadEating,
      this.boredEating,
      this.lonelyEating,
      this.dailyEating,
      this.sevenSleeping,
      this.largeEating,
      this.watchingEating,
      this.freeTimeEating,
      this.waterHabit,
      this.lateNightHabit,
      this.category});

  MindQuestions.fromJson(Map<String, dynamic> json) {
    control = json['Control'] != null ? json['Control'] : "";
    preoccupied = json['Preoccupied'] != null ? json['Preoccupied'] : "";
    freeFood = json['FreeFood'] != null ? json['FreeFood'] : "";
    eatingRound = json['EatingRound'] != null ? json['EatingRound'] : "";
    cravings = json['Cravings'] != null ? json['Cravings'] : "";
    craveFoods = json['CraveFoods'] != null ? json['CraveFoods'] : "";
    stressedEating =
        json['StressedEating'] != null ? json['StressedEating'] : "";
    sadEating = json['SadEating'] != null ? json['SadEating'] : "";
    boredEating = json['BoredEating'] != null ? json['BoredEating'] : "";
    lonelyEating = json['LonelyEating'] != null ? json['LonelyEating'] : "";
    dailyEating = json['DailyEating'] != null ? json['DailyEating'] : "";
    sevenSleeping = json['SevenSleeping'] != null ? json['SevenSleeping'] : "";
    largeEating = json['LargeEating'] != null ? json['LargeEating'] : "";
    watchingEating =
        json['WatchingEating'] != null ? json['WatchingEating'] : "";
    freeTimeEating =
        json['FreeTimeEating'] != null ? json['FreeTimeEating'] : "";
    waterHabit = json['WaterHabit'] != null ? json['WaterHabit'] : "";
    lateNightHabit =
        json['LateNightHabit'] != null ? json['LateNightHabit'] : "";
    category = json['Category'] != null ? json['Category'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Control'] = this.control;
    data['Preoccupied'] = this.preoccupied;
    data['FreeFood'] = this.freeFood;
    data['EatingRound'] = this.eatingRound;
    data['Cravings'] = this.cravings;
    data['CraveFoods'] = this.craveFoods;
    data['StressedEating'] = this.stressedEating;
    data['SadEating'] = this.sadEating;
    data['BoredEating'] = this.boredEating;
    data['LonelyEating'] = this.lonelyEating;
    data['DailyEating'] = this.dailyEating;
    data['SevenSleeping'] = this.sevenSleeping;
    data['LargeEating'] = this.largeEating;
    data['WatchingEating'] = this.watchingEating;
    data['FreeTimeEating'] = this.freeTimeEating;
    data['WaterHabit'] = this.waterHabit;
    data['LateNightHabit'] = this.lateNightHabit;
    data['Category'] = this.category;
    return data;
  }
}

class ExerciseQuestions {
  String routine;
  int activityLevel;
  String memberShip;
  String exerciseType;
  String bodyType;
  String minExercise;

  ExerciseQuestions(
      {this.routine,
      this.activityLevel,
      this.memberShip,
      this.exerciseType,
      this.bodyType,
      this.minExercise});

  ExerciseQuestions.fromJson(Map<String, dynamic> json) {
    routine = json['Routine'] != null ? json['Routine'] : "";
    activityLevel = json['ActivityLevel'] != null ? json['ActivityLevel'] : 0;
    memberShip = json['MemberShip'] != null ? json['MemberShip'] : "";
    exerciseType = json['ExerciseType'] != null ? json['ExerciseType'] : "";
    bodyType = json['BodyType'] != null ? json['BodyType'] : "";
    minExercise = json['MinExercise'] != null ? json['MinExercise'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Routine'] = this.routine;
    data['ActivityLevel'] = this.activityLevel;
    data['MemberShip'] = this.memberShip;
    data['ExerciseType'] = this.exerciseType;
    data['BodyType'] = this.bodyType;
    data['MinExercise'] = this.minExercise;
    return data;
  }
}
