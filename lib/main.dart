import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './widgets/workout_list.dart';
import '../models/workoutClass.dart';
import './widgets/addWorkout.dart';

void main() {
  runApp(WorkoutMain());
}

class WorkoutMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Record',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>

{
  final List<workout> _uworkout = [];

  @override

  // adding workout function to the list
  void _addWorkout(double minutes, double bmi, DateTime selectedDate) {
    final newWork = workout(
      minutes: minutes,
      bmi: bmi,
      id: DateTime.now().toString(),
      date: selectedDate,
    );

    setState(() {
      _uworkout.add(newWork);
    });
  }

  // deleting workout using ID of workout
  void _deleteWorkout(String worktID) {
    setState(() {
      _uworkout.removeWhere((index) => (index.id == worktID));
    });
  }

  void _startAddNewWorkout(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return newWorkout(_addWorkout);
      },
    );
  }

  // main page look
  List<Widget> pagelook(
      AppBar appBar,
      Widget txList) {
    return [txList];
  }

  @override
  Widget build(BuildContext context) {
    final dynamic appBar = AppBar(
      title: const Text('Workout Record'),
    );

    final txList =
        SizedBox(height: 640, child: ListWorkout(_uworkout, _deleteWorkout));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ...pagelook(
                  appBar,
                  txList),
            ],
          ),
        ),
      ),

      // add button for user to click on for adding a new workout
      floatingActionButton: Platform.isIOS
          // checks platform
          ? Container()
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _startAddNewWorkout(context),
            ),
    );
  }
}
