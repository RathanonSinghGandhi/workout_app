import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/workoutClass.dart';

class workoutInfo extends StatelessWidget {
  const workoutInfo({
    Key? key,
    required this.workt,
    required this.deleteWorkout,
  }) : super(key: key);
  

  final workout workt;
  final Function deleteWorkout;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          child: Padding(
            padding: const EdgeInsets.all(5),
            // BMI value shown in a Circle in each card
            child: FittedBox(child: Text('${workt.bmi} BMI', style: TextStyle(fontSize:12),),),
          ),
        ),
        // the number of minutes that the user puts in the field, is shown in the card
        title: Text('${workt.minutes} minutes', style: TextStyle(fontSize:20),),
        // the Date that the user chooses, shown as a subtitle in the card
        subtitle: Text(DateFormat.yMMMd().format(workt.date)),
        // the delete button on the right side of the card, in case user wants to delete their record
        trailing: MediaQuery.of(context).size.width > 460
            ? IconButton(
                onPressed: () => deleteWorkout(workt.id),
                icon: const Icon(Icons.delete),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteWorkout(workt.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
