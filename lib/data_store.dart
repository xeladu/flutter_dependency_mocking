class DataStore {
  final Map<String, dynamic> _store = <String, dynamic>{};

  void add(String identifier, dynamic data) {
    if (_store.containsKey(identifier)) {
      throw DataStoreException(
          "Identifier already in store! Use the update method!");
    }

    _store[identifier] = data;
  }

  void remove(String identifier) {
    if (_store.containsKey(identifier)) _store.remove(identifier);

    throw DataStoreException("Identifier not found!");
  }

  void update(String identifier, dynamic data) {
    if (!_store.containsKey(identifier)) {
      throw DataStoreException(
          "Identifier not in store yet! Use the add method!");
    }

    _store[identifier] = data;
  }

  dynamic get(String identifier) {
    return _store[identifier];
  }
}

class DataStoreException implements Exception {
  final String message;

  DataStoreException(this.message);
}
