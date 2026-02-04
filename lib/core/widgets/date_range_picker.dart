import 'package:agency_finance/core/theme/app_theme.dart';
import 'package:agency_finance/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerSheet extends StatefulWidget {
  const DateRangePickerSheet({
    required this.initialDateRange,
    super.key,
  });

  final DateTimeRange? initialDateRange;

  static Future<DateTimeRange?> show(BuildContext context, {DateTimeRange? initialRange}) {
    return showModalBottomSheet<DateTimeRange>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DateRangePickerSheet(initialDateRange: initialRange),
    );
  }

  @override
  State<DateRangePickerSheet> createState() => _DateRangePickerSheetState();
}

class _DateRangePickerSheetState extends State<DateRangePickerSheet> {
  late DateTimeRange? _selectedRange;

  @override
  void initState() {
    super.initState();
    _selectedRange = widget.initialDateRange;
  }

  void _selectPreset(int days) {
    final now = DateTime.now();
    setState(() {
      _selectedRange = DateTimeRange(
        start: now.subtract(Duration(days: days)),
        end: now,
      );
    });
  }

  Future<void> _pickCustomRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _selectedRange,
    );
    if (picked != null) {
      setState(() {
        _selectedRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;
    final dateFormatter = DateFormat.yMMMd();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Select Date Range', style: typography.title),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ActionChip(label: const Text('Today'), onPressed: () => _selectPreset(0)),
                ActionChip(label: const Text('Last 7 Days'), onPressed: () => _selectPreset(7)),
                ActionChip(label: const Text('Last 30 Days'), onPressed: () => _selectPreset(30)),
                ActionChip(label: const Text('This Month'), onPressed: () {
                  final now = DateTime.now();
                  setState(() {
                    _selectedRange = DateTimeRange(
                      start: DateTime(now.year, now.month),
                      end: now,
                    );
                  });
                }),
                ActionChip(label: const Text('Custom'), onPressed: _pickCustomRange),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: colors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedRange != null
                        ? '${dateFormatter.format(_selectedRange!.start)} - ${dateFormatter.format(_selectedRange!.end)}'
                        : 'No range selected',
                    style: typography.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.calendar_today, color: colors.textSecondary, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    onPressed: () => Navigator.pop(context),
                    label: 'Cancel',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => Navigator.pop(context, _selectedRange),
                    label: 'Apply',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
