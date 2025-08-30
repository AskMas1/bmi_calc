import 'package:flutter/material.dart';
import '../models/bmi_result.dart';
import '../widgets/custom_button.dart';
import '../services/storage_service.dart';

class ResultScreen extends StatelessWidget {
  final BMIResult result;

  const ResultScreen({super.key, required this.result});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Result',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFF0A0E21),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1E33),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        result.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _getResultColor(),
                          letterSpacing: 1.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _getResultColor(),
                            width: 3,
                          ),
                        ),
                        child: Text(
                          result.bmi.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            'Normal BMI range:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8D8E98),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '18.5 - 25 kg/m²',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _getResultColor(),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Your ideal weight range:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8D8E98),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            result.idealWeightRange,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _getResultColor(),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        result.interpretation,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'SAVE RESULT',
              onPressed: () async {
                await StorageService.saveResult(result);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Result saved successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            CustomButton(
              text: 'RE-CALCULATE',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
