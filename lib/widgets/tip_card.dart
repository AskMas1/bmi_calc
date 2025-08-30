import 'package:flutter/material.dart';

class TipCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> details;

  const TipCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.details,
  });

  @override
  State<TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<TipCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF1D1E33),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEB1555).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFFEB1555),
                  size: 24,
                ),
              ),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8D8E98),
                ),
              ),
              trailing: AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(
                  Icons.expand_more,
                  color: Color(0xFF8D8E98),
                ),
              ),
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: Color(0xFF8D8E98),
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 8),
                    ...widget.details.map(
                      (detail) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFF66BB6A),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                detail,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
