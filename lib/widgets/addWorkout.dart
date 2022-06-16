import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class newWorkout extends StatefulWidget {
  final Function addWkt;

  newWorkout(this.addWkt);

  @override
  _newWorkoutState createState() => _newWorkoutState();
}

// input controller
class _newWorkoutState extends State<newWorkout> {
  final _minutesController = TextEditingController();
  final _bmiController = TextEditingController();

  DateTime _selectedDate = DateTime(2018);

  void _submission() {
    final mins = double.parse(_minutesController.text);
    final bmiVal = double.parse(_bmiController.text);

    // fields cannot be empty
    if (mins <= 0 || _selectedDate == DateTime(2018)) {
      return;
    }

    widget.addWkt(mins, bmiVal, _selectedDate);
    Navigator.of(context).pop();
  }

  // shows that field cannot be empty
  String? get _errorText {
    final text = _bmiController.value.text;

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }

    return null;
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Minutes Text Field
              TextField(
                decoration: InputDecoration(
                    labelText: 'Minutes', errorText: _errorText),
                keyboardType: TextInputType.number,
                controller: _minutesController,
                onSubmitted: (_) => _submission(),
              ),
              // BMI Text Field
              TextField(
                decoration: InputDecoration(
                    labelText: 'BMI (Insert your latest BMI)',
                    errorText: _errorText),
                keyboardType: TextInputType.number,
                controller: _bmiController,
                onSubmitted: (_) => _submission(),
              ),
              // Date Selection
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == DateTime(2018)
                            ? 'No date selected!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    MaterialButton(
                      onPressed: _pickDate,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                color: Colors.green,
                child: const Text(
                  'Add Workout',
                ),
                textColor: Colors.white,
                onPressed: _submission,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
