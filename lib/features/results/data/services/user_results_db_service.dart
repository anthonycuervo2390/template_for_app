import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:firestore_demo/core/data/res/data_constants.dart';
import 'package:firestore_demo/features/results/data/model/user_result_model.dart';

final resultsDBS = DatabaseService<UserResult>(AppDBConstants.resultsCollection,
    fromDS: (id, data) => UserResult.fromDS(id, data),
    toMap: (wod) => wod.toMap());

// createCollection(){UserResultsDBService.collection =
// "${AppDBConstants.usersCollection}/${user.id}/results";
// }
