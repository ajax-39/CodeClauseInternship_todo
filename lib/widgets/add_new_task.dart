import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/task.dart';

class AddNewTask extends StatefulWidget {
  final String id;
  final bool isEditMode;

  const AddNewTask({
    super.key,
    required this.id,
    required this.isEditMode,
  });

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  late Task task;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  String? _inputDescription;
  final _formKey = GlobalKey<FormState>();

  void _pickUserDueDate() {
    showDatePicker(
            context: context,
            initialDate: widget.isEditMode
                ? (_selectedDate ?? DateTime.now())
                : DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  void _pickUserDueTime() {
    showTimePicker(
      context: context,
      initialTime: widget.isEditMode
          ? (_selectedTime ?? TimeOfDay.now())
          : TimeOfDay.now(),
    ).then((time) {
      if (time != null) {
        setState(() {
          _selectedTime = time;
        });
      }
    });
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_selectedDate == null && _selectedTime != null) {
        _selectedDate = DateTime.now();
      }
      if (!widget.isEditMode) {
        Provider.of<TaskProvider>(context, listen: false).createNewTask(
          Task(
            id: DateTime.now().toString(),
            description: _inputDescription ?? '',
            dueDate: _selectedDate,
            dueTime: _selectedTime,
          ),
        );
      } else {
        Provider.of<TaskProvider>(context, listen: false).editTask(
          Task(
            id: task.id,
            description: _inputDescription ?? '',
            dueDate: _selectedDate,
            dueTime: _selectedTime,
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (widget.isEditMode) {
      task =
          Provider.of<TaskProvider>(context, listen: false).getById(widget.id);
      _selectedDate = task.dueDate;
      _selectedTime = task.dueTime;
      _inputDescription = task.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Title', style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  initialValue: _inputDescription,
                  decoration: const InputDecoration(
                    hintText: 'Describe your task',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _inputDescription = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Due date',
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  onTap: () {
                    _pickUserDueDate();
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: _selectedDate == null
                        ? 'Provide your due date'
                        : DateFormat.yMMMd().format(_selectedDate!),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Due time',
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  onTap: () {
                    _pickUserDueTime();
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: _selectedTime == null
                        ? 'Provide your due time'
                        : _selectedTime!.format(context),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: Text(
                      !widget.isEditMode ? 'ADD TASK' : 'EDIT TASK',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontFamily: 'Lato',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _validateForm();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
