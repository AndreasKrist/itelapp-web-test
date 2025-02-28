import 'package:flutter/material.dart';
import 'category_chip.dart';

class FilterModal extends StatefulWidget {
  final String activeFilter;
  final Function(String) onFilterSelected;
  final Function() onApply;
  final Function() onCancel;

  const FilterModal({
    super.key,
    required this.activeFilter,
    required this.onFilterSelected,
    required this.onApply,
    required this.onCancel,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late String _currentFilter;

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.activeFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Courses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: widget.onCancel,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Funding section
          Text(
            'Funding',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              CategoryChip(
                label: 'All',
                isActive: _currentFilter == 'all',
                onTap: () {
                  setState(() {
                    _currentFilter = 'all';
                  });
                  widget.onFilterSelected('all');
                },
              ),
              CategoryChip(
                label: 'Funding Available',
                isActive: _currentFilter == 'funding',
                onTap: () {
                  setState(() {
                    _currentFilter = 'funding';
                  });
                  widget.onFilterSelected('funding');
                },
              ),
              CategoryChip(
                label: 'No Funding',
                isActive: _currentFilter == 'noFunding',
                onTap: () {
                  setState(() {
                    _currentFilter = 'noFunding';
                  });
                  widget.onFilterSelected('noFunding');
                },
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Course Duration section
          Text(
            'Course Duration',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              CategoryChip(
                label: 'All',
                isActive: _currentFilter == 'all',
                onTap: () {
                  setState(() {
                    _currentFilter = 'all';
                  });
                  widget.onFilterSelected('all');
                },
              ),
              CategoryChip(
                label: 'Short (< 8 weeks)',
                isActive: _currentFilter == 'short',
                onTap: () {
                  setState(() {
                    _currentFilter = 'short';
                  });
                  widget.onFilterSelected('short');
                },
              ),
              CategoryChip(
                label: 'Long (8+ weeks)',
                isActive: _currentFilter == 'long',
                onTap: () {
                  setState(() {
                    _currentFilter = 'long';
                  });
                  widget.onFilterSelected('long');
                },
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Certification Type section
          Text(
            'Certification Type',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              CategoryChip(
                label: 'All',
                isActive: _currentFilter == 'all',
                onTap: () {
                  setState(() {
                    _currentFilter = 'all';
                  });
                  widget.onFilterSelected('all');
                },
              ),
              CategoryChip(
                label: 'CCNA',
                isActive: _currentFilter == 'ccna',
                onTap: () {
                  setState(() {
                    _currentFilter = 'ccna';
                  });
                  widget.onFilterSelected('ccna');
                },
              ),
              CategoryChip(
                label: 'CEH',
                isActive: _currentFilter == 'ceh',
                onTap: () {
                  setState(() {
                    _currentFilter = 'ceh';
                  });
                  widget.onFilterSelected('ceh');
                },
              ),
              CategoryChip(
                label: 'CCNP',
                isActive: _currentFilter == 'ccnp',
                onTap: () {
                  setState(() {
                    _currentFilter = 'ccnp';
                  });
                  widget.onFilterSelected('ccnp');
                },
              ),
              CategoryChip(
                label: 'SCTP',
                isActive: _currentFilter == 'sctp',
                onTap: () {
                  setState(() {
                    _currentFilter = 'sctp';
                  });
                  widget.onFilterSelected('sctp');
                },
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Sort By section
          Text(
            'Sort By',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              CategoryChip(
                label: 'Price: Low to High',
                isActive: _currentFilter == 'priceLow',
                onTap: () {
                  setState(() {
                    _currentFilter = 'priceLow';
                  });
                  widget.onFilterSelected('priceLow');
                },
              ),
              CategoryChip(
                label: 'Price: High to Low',
                isActive: _currentFilter == 'priceHigh',
                onTap: () {
                  setState(() {
                    _currentFilter = 'priceHigh';
                  });
                  widget.onFilterSelected('priceHigh');
                },
              ),
              CategoryChip(
                label: 'Duration',
                isActive: _currentFilter == 'duration',
                onTap: () {
                  setState(() {
                    _currentFilter = 'duration';
                  });
                  widget.onFilterSelected('duration');
                },
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}