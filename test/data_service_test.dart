import 'package:flutter_dependency_mocking/data_service.dart';
import 'package:flutter_dependency_mocking/data_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'data_service_test.mocks.dart';

@GenerateMocks([DataStore])
void main() {
  test("Verify get returns values", () {
    var storeMock = MockDataStore();
    var service = DataService(storeMock);

    when(storeMock.get(any)).thenReturn("I am a value!");

    expect("I am a value!", service.get("dummy"));
    verify(storeMock.get(any)).called(1);
  });
}
