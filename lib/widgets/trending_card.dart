import 'package:flutter/material.dart';
import '../models/trending_item.dart';

class TrendingCard extends StatelessWidget {
  final TrendingItem item;

  const TrendingCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  item.category,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                item.type == TrendingItemType.event || item.date != null
                    ? Icons.calendar_today
                    : Icons.access_time,
                color: Colors.grey[400],
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                item.date ?? item.readTime ?? '',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}