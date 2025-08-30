import 'package:flutter/material.dart';
import '../models/bmi_result.dart';
import '../services/storage_service.dart';
import '../widgets/bmi_history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<BMIResult> _results = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    setState(() {
      _isLoading = true;
    });
    
    final results = await StorageService.getResults();
    
    setState(() {
      _results = results;
      _isLoading = false;
    });
  }

  Future<void> _deleteResult(int index) async {
    await StorageService.deleteResult(index);
    _loadResults();
  }

  Future<void> _clearAllResults() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1D1E33),
        title: const Text(
          'Clear All History',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to delete all BMI results?',
          style: TextStyle(color: Color(0xFF8D8E98)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete All',
              style: TextStyle(color: Color(0xFFEB1555)),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await StorageService.clearAllResults();
      _loadResults();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI History',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        actions: [
          if (_results.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.white),
              onPressed: _clearAllResults,
              tooltip: 'Clear All',
            ),
        ],
      ),
      backgroundColor: const Color(0xFF0A0E21),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEB1555)),
              ),
            )
          : _results.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 100,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No BMI calculations yet',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start calculating your BMI to see history',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadResults,
                  color: const Color(0xFFEB1555),
                  backgroundColor: const Color(0xFF1D1E33),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final result = _results[index];
                      return BMIHistoryCard(
                        result: result,
                        onDelete: () => _deleteResult(index),
                      );
                    },
                  ),
                ),
    );
  }
}
