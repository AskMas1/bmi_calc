import 'package:flutter/material.dart';

class HeightSlider extends StatelessWidget {
  final int height;
  final ValueChanged<double> onChanged;

  const HeightSlider({
    super.key,
    required this.height,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1E33),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'HEIGHT',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8D8E98),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                height.toString(),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'cm',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF8D8E98),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              inactiveTrackColor: const Color(0xFF8D8E98),
              activeTrackColor: Colors.white,
              thumbColor: const Color(0xFFEB1555),
              overlayColor: const Color(0x29EB1555),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
            ),
            child: Slider(
              value: height.toDouble(),
              min: 120.0,
              max: 220.0,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
