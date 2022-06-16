import 'package:flutter/material.dart';
import '../widgets/workouts.dart';
import '../models/workoutClass.dart';

class ListWorkout extends StatelessWidget {
  final List<workout> workt;
  final Function deleteWorkout;
   ListWorkout(this.workt, this.deleteWorkout);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: constraints.maxHeight * 0.9,
        // When the list is empty, it shows that no workout is added so far
        child: workt.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(150.0),
                        child: Text(
                          'No Workout is added!',
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              )

        // This listview builder constructor is to build the list of workouts to be shown
        // on the screen when the workout gets added. Everytime a new workout is added,
        // it adds the list and will be shown on the screen right away.
            : ListView.builder(
                itemBuilder: (context, index) {
                  return workoutInfo(workt: workt[index], deleteWorkout: deleteWorkout);
                },
                itemCount: workt.length,
              ),
      );
    });
  }
}


