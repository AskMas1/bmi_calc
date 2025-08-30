import 'package:flutter/material.dart';
import '../models/bmi_result.dart';

class BMIHistoryCard extends StatelessWidget {
  final BMIResult result;
  final VoidCallback onDelete;

  const BMIHistoryCard({
    super.key,
    required this.result,
    required this.onDelete,
  });

  Color _getResultColor() {
    if (result.bmi < 18.5) {
      return const Color(0xFF4FC3F7);
    } else if (result.bmi >= 18.5 && result.bmi < 25) {
      return const Color(0xFF66BB6A);
    } else if (result.bmi >= 25 && result.bmi < 30) {
      return const Color(0xFFFFB74D);
    } else {
      return const Color(0xFFEF5350);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF1D1E33),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // BMI Circle
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getResultColor(),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  result.bmi.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _getResultColor(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.category,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _getResultColor(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${result.height}cm • ${result.weight}kg • ${result.age}yrs',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8D8E98),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(result.date),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8D8E98),
                    ),
                  ),
                ],
              ),
            ),
            // Delete Button
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Color(0xFFEB1555),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1D1E33),
                    title: const Text(
                      'Delete Result',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      'Are you sure you want to delete this BMI result?',
                      style: TextStyle(color: Color(0xFF8D8E98)),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onDelete();
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Color(0xFFEB1555)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
