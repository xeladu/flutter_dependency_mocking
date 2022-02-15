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

  void update(String identifier, {dynamic data}) {
    if (!_store.containsKey(identifier)) {
      throw DataStoreException(
          "Identifier not in store yet! Use the add method!");
    }

    _store[identifier] = data;
  }

  dynamic get(String identifier) async {
    return _store[identifier];
  }

  Future<void> addAsync(String identifier, dynamic data) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (_store.containsKey(identifier)) {
      throw DataStoreException(
          "Identifier already in store! Use the update method!");
    }

    _store[identifier] = data;
  }

  Future<void> removeAsync(String identifier) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (_store.containsKey(identifier)) _store.remove(identifier);

    throw DataStoreException("Identifier not found!");
  }

  Future<void> updateAsync(String identifier, {dynamic data}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (!_store.containsKey(identifier)) {
      throw DataStoreException(
          "Identifier not in store yet! Use the add method!");
    }

    _store[identifier] = data;
  }

  Future<dynamic> getAsync(String identifier) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _store[identifier];
  }
}

class DataStoreException implements Exception {
  final String message;

  DataStoreException(this.message);
}
