import 'package:flutter/material.dart';
import '../models/bmi_result.dart';

class GenderCard extends StatelessWidget {
  final Gender gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D1E33) : const Color(0xFF111328),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFEB1555) : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFEB1555).withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              gender == Gender.male ? Icons.male : Icons.female,
              size: 80,
              color: isSelected ? Colors.white : const Color(0xFF8D8E98),
            ),
            const SizedBox(height: 12),
            Text(
              gender == Gender.male ? 'MALE' : 'FEMALE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xFF8D8E98),
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
