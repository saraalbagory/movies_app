import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/features/watchList/data/models/watchlist_model.dart';


class WatchlistDataSource {
  final CollectionReference<WatchlistModel> _collection =
      FirebaseFirestore.instance
          .collection('watchlist')
          .withConverter<WatchlistModel>(
            fromFirestore: (snapshot, _) =>
                WatchlistModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (item, _) => item.toJson(),
          );

  Future<void> addItemToWatchlist(WatchlistModel item) async {
    await _collection.doc(item.id).set(item);
  }

  Future<void> removeItemFromWatchlist(String id) async {
    await _collection.doc(id).delete();
  }

  Stream<List<WatchlistModel>> getWatchlistItems() {
    return _collection.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data())
              .toList(),
        );
  }
}
