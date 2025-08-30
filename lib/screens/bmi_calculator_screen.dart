import 'package:flutter/material.dart';
import '../models/bmi_result.dart';
import '../screens/result_screen.dart';
import '../widgets/gender_card.dart';
import '../widgets/height_slider.dart';
import '../widgets/weight_age_card.dart';
import '../widgets/custom_button.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  Gender selectedGender = Gender.none;
  int height = 180;
  int weight = 70;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gender Selection
              SizedBox(
                height: 180,
                child: Row(
                  children: [
                    Expanded(
                      child: GenderCard(
                        gender: Gender.male,
                        isSelected: selectedGender == Gender.male,
                        onTap: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GenderCard(
                        gender: Gender.female,
                        isSelected: selectedGender == Gender.female,
                        onTap: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Height Slider
              SizedBox(
                height: 180,
                child: HeightSlider(
                  height: height,
                  onChanged: (value) {
                    setState(() {
                      height = value.round();
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Weight and Age
              SizedBox(
                height: 180,
                child: Row(
                  children: [
                    Expanded(
                      child: WeightAgeCard(
                        title: 'WEIGHT',
                        value: weight,
                        unit: 'kg',
                        onIncrement: () {
                          setState(() {
                            weight++;
                          });
                        },
                        onDecrement: () {
                          setState(() {
                            if (weight > 1) weight--;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: WeightAgeCard(
                        title: 'AGE',
                        value: age,
                        unit: 'years',
                        onIncrement: () {
                          setState(() {
                            age++;
                          });
                        },
                        onDecrement: () {
                          setState(() {
                            if (age > 1) age--;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Calculate Button
              CustomButton(
                text: 'CALCULATE BMI',
                onPressed: () {
                  if (selectedGender == Gender.none) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select your gender'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  double bmi = weight / ((height / 100) * (height / 100));
                  BMIResult result = BMIResult(
                    bmi: bmi,
                    gender: selectedGender,
                    height: height,
                    weight: weight,
                    age: age,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(result: result),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16), // Extra bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
