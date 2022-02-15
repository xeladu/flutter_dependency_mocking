import 'data_store.dart';

class DataService {
  final DataStore store;
  DataService(this.store);

  dynamic get(String identifier) {
    return store.get(identifier);
  }

  void add(String identifier, dynamic data) {
    store.add(identifier, data);
  }

  void update(String identifier, dynamic data) {
    store.update(identifier, data: data);
  }

  void remove(String identifier) {
    store.remove(identifier);
  }

  Future<dynamic> getAsync(String identifier) async {
    return await store.getAsync(identifier);
  }

  Future addAsync(String identifier, dynamic data) async {
    await store.addAsync(identifier, data);
  }

  Future updateAsync(String identifier, dynamic data) async {
    await store.updateAsync(identifier, data: data);
  }

  Future removeAsync(String identifier) async {
    await store.removeAsync(identifier);
  }
}
