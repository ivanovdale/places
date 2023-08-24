import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

DatabaseConnection connect(
  String dbName, {
  bool logStatements = false,
}) {
  return DatabaseConnection.delayed(
    Future.sync(
      () async {
        final dbFolder = await getApplicationDocumentsDirectory();
        final file = File(path.join(dbFolder.path, dbName));

        return DatabaseConnection(
          NativeDatabase.createInBackground(
            file,
            logStatements: logStatements,
          ),
        );
      },
    ),
  );
}
