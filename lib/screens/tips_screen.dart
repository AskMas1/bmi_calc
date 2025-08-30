import 'package:flutter/material.dart';
import '../widgets/tip_card.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  final List<Map<String, dynamic>> _tips = const [
    {
      'icon': Icons.restaurant,
      'title': 'Healthy Eating',
      'description': 'Focus on whole foods, lean proteins, and plenty of fruits and vegetables.',
      'details': [
        'Eat 5-6 small meals throughout the day',
        'Include protein in every meal',
        'Choose complex carbohydrates over simple sugars',
        'Stay hydrated with 8-10 glasses of water daily',
        'Limit processed foods and added sugars',
      ],
    },
    {
      'icon': Icons.fitness_center,
      'title': 'Regular Exercise',
      'description': 'Aim for at least 150 minutes of moderate exercise per week.',
      'details': [
        'Include both cardio and strength training',
        'Start with 20-30 minutes of daily activity',
        'Take stairs instead of elevators',
        'Walk or bike for short distances',
        'Find activities you enjoy to stay motivated',
      ],
    },
    {
      'icon': Icons.bedtime,
      'title': 'Quality Sleep',
      'description': 'Get 7-9 hours of quality sleep each night for optimal health.',
      'details': [
        'Maintain a consistent sleep schedule',
        'Create a relaxing bedtime routine',
        'Avoid screens 1 hour before bed',
        'Keep your bedroom cool and dark',
        'Limit caffeine intake after 2 PM',
      ],
    },
    {
      'icon': Icons.self_improvement,
      'title': 'Stress Management',
      'description': 'Practice stress reduction techniques for better overall health.',
      'details': [
        'Try meditation or deep breathing exercises',
        'Practice yoga or tai chi',
        'Spend time in nature',
        'Connect with friends and family',
        'Consider journaling or therapy if needed',
      ],
    },
    {
      'icon': Icons.local_drink,
      'title': 'Stay Hydrated',
      'description': 'Proper hydration supports metabolism and overall health.',
      'details': [
        'Drink water before, during, and after exercise',
        'Start your day with a glass of water',
        'Eat water-rich foods like fruits and vegetables',
        'Monitor urine color as a hydration indicator',
        'Limit alcohol and sugary drinks',
      ],
    },
    {
      'icon': Icons.monitor_heart,
      'title': 'Regular Check-ups',
      'description': 'Monitor your health with regular medical check-ups.',
      'details': [
        'Schedule annual physical exams',
        'Monitor blood pressure and cholesterol',
        'Keep track of your BMI trends',
        'Discuss any concerns with your doctor',
        'Follow preventive care recommendations',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Health Tips',
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _tips.length,
        itemBuilder: (context, index) {
          final tip = _tips[index];
          return TipCard(
            icon: tip['icon'],
            title: tip['title'],
            description: tip['description'],
            details: List<String>.from(tip['details']),
          );
        },
      ),
    );
  }
}
