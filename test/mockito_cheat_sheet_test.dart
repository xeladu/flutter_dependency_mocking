import 'package:flutter_dependency_mocking/data_service.dart';
import 'package:flutter_dependency_mocking/data_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'data_service_test.mocks.dart';

@GenerateMocks([DataStore])
void main() {
  final mock = MockDataStore();
  final sut = DataService(mock);

  test("Setup", () async {
    //////////////////////////////////
    // --- Define return values --- //
    //////////////////////////////////

    // Returns a Future without a value
    when(mock.addAsync(any, any))
        .thenAnswer((realInvocation) => Future.value());
    await sut.addAsync("2", "2");
    verify(mock.addAsync(any, any)).called(1);

    // Returns a Future with a value
    when(mock.getAsync(any)).thenAnswer((realInvocation) => Future.value("42"));
    expect(await sut.getAsync("2"), "42");
    verify(mock.getAsync(any)).called(1);

    //////////////////////////////
    // --- Throw exceptions --- //
    //////////////////////////////

    // Throws exception
    when(mock.removeAsync(any)).thenThrow(Exception());
    when(mock.remove(any)).thenThrow(Exception());
    expect(() => sut.remove("1"), throwsA(isA<Exception>()));
    expect(() async => await sut.removeAsync("1"), throwsA(isA<Exception>()));
    verify(mock.remove(any)).called(1);
    verify(mock.removeAsync(any)).called(1);

    /////////////////////////////////////
    // --- Using argument matchers --- //
    /////////////////////////////////////

    // Matches on any argument
    when(mock.get(any)).thenAnswer((realInvocation) => "42");
    expect(mock.get(null) == "42", isTrue);

    // Matches on any argument of type string
    when(mock.get(argThat(isA<String>()))).thenAnswer((realInvocation) => "42");
    expect(mock.get("") == "42", isTrue);

    // Matches on any named argument
    when(mock.updateAsync(any, data: anyNamed("data")))
        .thenAnswer((realInvocation) => Future.value());
    await mock.updateAsync("dummy", data: 123);
    verify(mock.updateAsync(any, data: anyNamed("data"))).called(1);

    /////////////////////////////////
    // --- Capturing arguments --- //
    /////////////////////////////////

    // Captures the arguments
    await mock.updateAsync("test", data: 321);
    expect(
        verify(mock.updateAsync(captureAny, data: captureAnyNamed("data")))
            .captured,
        ["test", 321]);

    // Captures the arguments according to a condition
    await mock.updateAsync("test", data: 321);
    await mock.updateAsync("not a test", data: 322);
    await mock.updateAsync("testme", data: 323);
    expect(
        verify(mock.updateAsync(captureThat(startsWith("t")),
                data: captureAnyNamed("data")))
            .captured,
        ["test", 321, "testme", 323]);

    //////////////////////////
    // --- Verification --- //
    //////////////////////////

    clearInteractions(mock);

    // Verifies the amount of calls
    mock.get("111");
    mock.get("222");
    verify(mock.get(any)).called(2);
    mock.get("111");
    mock.get("222");
    verify(mock.get(any)).called(lessThan(3));

    // Verifies a mock wasn't called with the given arguments
    verifyNever(mock.get("123"));

    // Verifies the order of call
    mock.get("get");
    mock.add("add", "add");
    mock.get("get");
    verifyInOrder([mock.get(any), mock.add(any, any), mock.get(any)]);

    // Verifies that there weren't anymore calls after the last verification
    verifyNoMoreInteractions(mock);

    reset(mock);

    // Verifies that the mock wasn't called at all
    verifyZeroInteractions(mock);

    ///////////////////////
    // --- Resetting --- //
    ///////////////////////

    // Removes all stubs, clears captured calls
    reset(mock);

    // Clears captured calls
    clearInteractions(mock);
  });
}
