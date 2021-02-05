import 'package:firestore_demo/core/data/res/data_constants.dart';
import 'package:firestore_demo/features/wods/data/services/models/app_wod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

final wodDBS = DatabaseService<AppWod>(AppDBConstants.wodsCollection,
    fromDS: (id, data) => AppWod.fromDS(id, data),
    toMap: (wod) => wod.toMap());
