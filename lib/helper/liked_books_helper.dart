import 'dart:io';
import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class LikedBooksDB {
  getPath() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    final path = appDocDirectory.path + '/favorites.db';
    return path;
  }

  addToLiked(Map item) async {
    final database = ObjectDB(await getPath());
    database.open();
    database.insert(item);
    await database.close();
  }

  Future<int> removeFromLiked(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    int val = await db.remove(item);
    await db.close();
    return val;
  }

  Future<List> showAllLikedBooks() async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find({});
    await db.close();
    return val;
  }

  Future<List> isLiked(Map item) async {
    final db = ObjectDB(await getPath());
    db.open();
    List val = await db.find(item);
    await db.close();
    return val;
  }
}
