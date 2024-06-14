import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// This widget displays the text inside a ListItem.
// It shows the due date and due time if they exist.

class ItemText extends StatelessWidget {
  final bool check;
  final String text;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;

  const ItemText(
    this.check,
    this.text,
    this.dueDate,
    this.dueTime, {
    super.key,
  });

  Widget _buildText(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            decoration:
                check ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        _buildDateTimeTexts(context),
      ],
    );
  }

  Widget _buildDateText(BuildContext context) {
    return Text(
      DateFormat.yMMMd().format(dueDate!),
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTimeText(BuildContext context) {
    return Text(
      dueTime!.format(context),
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDateTimeTexts(BuildContext context) {
    // Check if both dueDate and dueTime are provided
    if (dueDate != null && dueTime != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildDateText(context),
          const SizedBox(width: 10),
          _buildTimeText(context),
        ],
      );
    }
    // Check if only dueDate is provided
    else if (dueDate != null) {
      return _buildDateText(context);
    }
    // Return an empty container if neither is provided
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return _buildText(context);
  }
}
