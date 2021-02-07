import 'dart:convert';

class AppWod {
  final String rounds;
  final String id;
  final String wodDescription;
  final DateTime date;
  final String
      userId; //TODO: esto es extra para poder mostrar info solo a este usuario
  final String weightliftingMovement;
  final String reps;
  final String weightliftingDescription;
  final String extrasDescription;
  final String scoring;
  AppWod({
    this.rounds,
    this.scoring,
    this.id,
    this.wodDescription,
    this.extrasDescription,
    this.weightliftingDescription,
    this.reps,
    this.date,
    this.userId,
    this.weightliftingMovement,
  });

  AppWod copyWith({
    String rounds,
    String scoring,
    String id,
    String reps,
    String wodDescription,
    DateTime date,
    String userId,
    String weightliftingMovement,
    String weightliftingDescription,
    String extrasDescription,
  }) {
    return AppWod(
      rounds: rounds ?? this.rounds,
      scoring: scoring ?? this.scoring,
      id: id ?? this.id,
      reps: reps ?? this.reps,
      wodDescription: wodDescription ?? this.wodDescription,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      weightliftingMovement:
          weightliftingMovement ?? this.weightliftingMovement,
      weightliftingDescription:
          weightliftingDescription ?? this.weightliftingDescription,
      extrasDescription: extrasDescription ?? this.extrasDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rounds': rounds,
      'scoring': scoring,
      'reps': reps,
      'id': id,
      'wodDescription': wodDescription,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'weightliftingMovement': weightliftingMovement,
      'weightliftingDescription': weightliftingDescription,
      'extrasDescription': extrasDescription,
    };
  }

//TODO: ESTO DE ABAJO LO COPIAMOS Y CAMBIAMOS EL FROMMAP POR FROMDS QUE SERAN LOS DOCUMENTOS QUE VENDRAN DE FIRESTORE
  factory AppWod.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AppWod(
      rounds: map['rounds'],
      scoring: map['scoring'],
      id: map['id'],
      reps: map['reps'],
      wodDescription: map['wodDescription'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['userId'],
      weightliftingDescription: map['weightliftingDescription'],
      weightliftingMovement: map['weightliftingMovement'],
      extrasDescription: map['extrasDescription'],
    );
  }

  //========DOCS FROM FIRESTORE========// LE AGREGAMOS STRING ID
  factory AppWod.fromDS(String id, Map<String, dynamic> data) {
    if (data == null) return null;

    return AppWod(
      rounds: data['rounds'],
      scoring: data['scoring'],
      id: id,
      reps: data['reps'],
      wodDescription: data['wodDescription'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      userId: data['user_id'],
      weightliftingDescription: data['weightliftingDescription'],
      weightliftingMovement: data['weightliftingMovement'],
      extrasDescription: data['extrasDescription'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppWod.fromJson(String source) => AppWod.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppEvent(rounds: $rounds, id: $id, wodDescription: $wodDescription, date: $date, scoring: $scoring, userId: $userId, reps: $reps, weightliftingDescription: $weightliftingDescription, weightliftingMovement: $weightliftingMovement, extrasDescription: $extrasDescription)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AppWod &&
        o.rounds == rounds &&
        o.scoring == scoring &&
        o.reps == reps &&
        o.id == id &&
        o.wodDescription == wodDescription &&
        o.date == date &&
        o.userId == userId &&
        o.weightliftingDescription == weightliftingDescription &&
        o.weightliftingMovement == weightliftingMovement &&
        o.extrasDescription == extrasDescription;
  }

  @override
  int get hashCode {
    return rounds.hashCode ^
        id.hashCode ^
        scoring.hashCode ^
        wodDescription.hashCode ^
        date.hashCode ^
        userId.hashCode ^
        reps.hashCode ^
        weightliftingDescription.hashCode ^
        weightliftingMovement.hashCode ^
        extrasDescription.hashCode;
  }
}
