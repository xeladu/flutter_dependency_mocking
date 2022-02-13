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
    store.update(identifier, data);
  }

  void remove(String identifier) {
    store.remove(identifier);
  }
}
