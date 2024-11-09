import 'package:flutter/material.dart';

class DataforRow extends StatelessWidget {
  final String value;
  final String condition;
  final String dateTime;

  const DataforRow({
    super.key,
    required this.value,
    required this.condition,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8.0), // Adjust spacing as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 10,
            ),
          ),
          Text(
            condition,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 10,
            ),
          ),
          Text(
            dateTime,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
