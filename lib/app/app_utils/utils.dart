
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Utils {
  static showProgressIndicator() {
    EasyLoading.show(dismissOnTap: true);
  }

  static disMissProgressIndicator() {
    EasyLoading.dismiss();
  }

  static dynamic checkUserId(String? userId) {
    if (userId != null && userId != "") {
      try {
        if (double.parse(userId).runtimeType == double && userId.length == 10) {
          return true;
        } else {
          return "Please enter valid mobile no";
        }
      } catch (e) {
        if (userId.isValidEmail()) {
          return true;
        } else {
          return "Please enter valid email id";
        }
      }
    } else {
      return "Please enter Email Id Or Mobile Number";
    }
  }

  static bool checkIsDouble(String id) {
    try {
      double.parse(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  static int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // Check if the birthday has not occurred yet this year
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static (int, int, int) calculateAgeWithYearMonthAndDay(DateTime birthDate) {
    try {
      DateTime today = DateTime.now();
      int years = today.year - birthDate.year;
      int months = today.month - birthDate.month;
      int days = today.day - birthDate.day;

      // Adjust for negative values
      if (days < 0) {
        // final previousMonth = DateTime(today.year, today.month - 1, birthDate.day);
        days += DateTime(today.year, today.month, 0).day; // Days in the previous month
        months--;
      }

      if (months < 0) {
        months += 12;
        years--;
      }

      return (years, months, days);
    } catch (e) {
      return (0, 0, 0);
    }
  }

  static String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 6) {
      return 'Good night';
    } else if (hour >= 6 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
