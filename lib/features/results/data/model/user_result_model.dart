import 'package:firebase_helpers/firebase_helpers.dart';

class UserResult extends DatabaseItem {
  String id;
  String name;
  String photoUrl;
  String userId;
  String minutesRounds;
  String secondsReps;
  DateTime date;
  String weight;
  String details;

  UserResult({
    this.id,
    this.name,
    this.minutesRounds,
    this.secondsReps,
    this.date,
    this.weight,
    this.details,
    this.userId,
    this.photoUrl,
  }) : super(id);

  UserResult.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        name = data['name'],
        userId = data['user_id'],
        date = DateTime.fromMillisecondsSinceEpoch(data['date']),
        minutesRounds = data['minutes_Rounds'],
        secondsReps = data['seconds_Reps'],
        weight = data['weight'],
        details = data['details'],
        photoUrl = data['photoUrl'],
        super(id);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['userId'] = userId;
    data['date'] = date;
    data['minutesRounds'] = minutesRounds;
    data['secondsReps'] = secondsReps;
    data['weight'] = weight;
    data['details'] = details;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
