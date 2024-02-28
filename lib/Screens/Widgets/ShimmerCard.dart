import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 16,
              color: Colors.grey[300],
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 16,
              color: Colors.grey[300],
            ),
            SizedBox(height: 8),
            Container(
              width: 100,
              height: 16,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}