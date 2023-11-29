import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int calculateAge(String birthDateStr, {String format = "yyyy-MM-dd"}) {
  DateTime today = DateTime.now();
  DateTime birthDate = DateTime.parse(birthDateStr);

  int age = today.year - birthDate.year;
  int month = today.month - birthDate.month;
  int day = today.day - birthDate.day;

  if (month < 0 || (month == 0 && day < 0)) {
    age--;
  }

  return age;
}

String centimetersToFeetAndInches(String cm) {
  // 1 foot = 30.48 centimeters
  // 1 inch = 2.54 centimeters
  double centimeters = double.parse(cm);
  // final double centimetersInFoot = 30.48;
  final double centimetersInInch = 2.54;

  int totalInches = (centimeters / centimetersInInch).round();
  int feet = totalInches ~/ 12; // 1 foot = 12 inches
  int inches = totalInches % 12;

  return '$feet\'$inches"';
}

String classifyBMI(double bmi) {
  // double bmi = double.parse(b);
  if (bmi < 18.5) {
    return 'Underweight';
    // Implement actions for underweight individuals
  }
  if (bmi >= 18.5 && bmi < 24.9) {
    return 'Normal Weight';
    // Implement actions for individuals with normal weight
  }
  if (bmi >= 25.0 && bmi < 29.9) {
    return 'Overweight';
    // Implement actions for overweight individuals
  }
  return "Obese";
}

String formatDateString(String dateString) {
  try {
    // Parse the input date string into a DateTime object
    DateTime date = DateTime.parse(dateString);

    // Define the date format for the desired output format
    final DateFormat outputFormat = DateFormat('dd MMMM yyyy', 'en_US');

    // Format the DateTime object as a string in the desired format
    String formattedDate = outputFormat.format(date);

    return formattedDate;
  } catch (e) {
    return 'Invalid Date'; // Handle invalid date format
  }
}

double calculateBMI(String weight, String height) {
  // BMI formula: BMI = weight (kg) / (height (m) * height (m))
  double weightInKg = double.parse(weight);
  double heightInCm = double.parse(height);
  double heightInMeters = heightInCm / 100.0;
  double bmi = weightInKg / (heightInMeters * heightInMeters);
  return bmi;
}

void showCustomDialog(
    BuildContext context, String title, String content, Function func) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontFamily: 'geb'),
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                return func();
              },
              child: Text('Yes'),
            ),
          ],
        );
      });
}

class Age {
  int years;
  int months;
  int days;

  Age({required this.years, required this.months, required this.days});
}

Age CalculateAge(String birthDateString) {
  DateTime today = DateTime.now();
  DateTime birthDate = DateTime.parse(birthDateString);

  int years = today.year - birthDate.year;
  int months = today.month - birthDate.month;
  int days = today.day - birthDate.day;

  if (months < 0 || (months == 0 && days < 0)) {
    years--;
    months += 12;
  }

  if (days < 0) {
    final daysInLastMonth =
        DateTime(today.year, today.month - 1, birthDate.day);
    days = today.difference(daysInLastMonth).inDays;
  }

  return Age(years: years, months: months, days: days);
}
