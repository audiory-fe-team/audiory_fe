import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class OfflineDatabase {
  static final OfflineDatabase _singleton = OfflineDatabase._();
  static OfflineDatabase get instance => _singleton;

  Completer<Database>? _dbOpenCompleter;

  OfflineDatabase._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'audiory_database.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter?.complete(database);
  }
}
