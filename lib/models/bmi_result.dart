enum Gender { male, female, none }

class BMIResult {
  final double bmi;
  final Gender gender;
  final int height;
  final int weight;
  final int age;
  final DateTime date;

  BMIResult({
    required this.bmi,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  String get category {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  String get interpretation {
    if (bmi < 18.5) {
      return 'You are underweight. Consider consulting a healthcare provider for personalized advice on healthy weight gain.';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'You have a normal body weight. Great job maintaining a healthy lifestyle!';
    } else if (bmi >= 25 && bmi < 30) {
      return 'You are overweight. Consider incorporating regular exercise and a balanced diet into your routine.';
    } else {
      return 'You are obese. It\'s recommended to consult with a healthcare provider for a comprehensive health plan.';
    }
  }

  String get idealWeightRange {
    double heightInM = height / 100.0;
    double minIdealWeight = 18.5 * heightInM * heightInM;
    double maxIdealWeight = 24.9 * heightInM * heightInM;
    return '${minIdealWeight.toStringAsFixed(1)} - ${maxIdealWeight.toStringAsFixed(1)} kg';
  }

  Map<String, dynamic> toJson() {
    return {
      'bmi': bmi,
      'gender': gender.toString(),
      'height': height,
      'weight': weight,
      'age': age,
      'date': date.toIso8601String(),
    };
  }

  factory BMIResult.fromJson(Map<String, dynamic> json) {
    return BMIResult(
      bmi: json['bmi'],
      gender: Gender.values.firstWhere(
        (g) => g.toString() == json['gender'],
        orElse: () => Gender.none,
      ),
      height: json['height'],
      weight: json['weight'],
      age: json['age'],
      date: DateTime.parse(json['date']),
    );
  }
}
