import 'package:flutter_test/flutter_test.dart';
import 'package:magic_app/network/APIProvider.dart';
import 'package:magic_app/network/NetworkError.dart';
import '../Helpers/Constants/Constants.dart';
import '../Helpers/Mocks/MockClient.dart';
import 'package:mockito/mockito.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  APIProvider sut;
  MockClient clientMock;
  String testPath;

  setUp(() {
    clientMock = MockClient();
    sut = APIProvider(testBaseURL, clientMock);
    testPath = "/test";
  });

  group("APIProvider -", () {
    group("GET", () {
      test("with no errors", () async {
        when(clientMock.get(testBaseURL + testPath))
            .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
        final response = await sut.get(testPath);
        final objDummy = TestObject.fromJSON(response);
        expect(objDummy.title, "Test");
      });

      test("with no internet", () async {
        when(clientMock.get(testBaseURL + testPath))
            .thenAnswer((_) async => throw SocketException("No internet"));

        expect(sut.get(testPath), throwsA(isA<FetchDataException>()));
      });

      test("with bad request ~ 400", () async {
        when(clientMock.get(testBaseURL + testPath))
            .thenAnswer((_) async => http.Response('Bad request', 400));

        expect(sut.get(testPath), throwsA(isA<BadRequestException>()));
      });

      test("with need authentication ~ 401", () async {
        when(clientMock.get(testBaseURL + testPath))
            .thenAnswer((_) async => http.Response('Need authentication', 401));

        expect(
            sut.get(testPath), throwsA(isA<AuthenticationRequiredException>()));
      });

      test("with unauthorised ~ 403", () async {
        when(clientMock.get(testBaseURL + testPath))
            .thenAnswer((_) async => http.Response('Unauthorised', 403));

        expect(sut.get(testPath), throwsA(isA<UnauthorisedException>()));
      });

      test("with server error  ~ 500", () async {
        when(clientMock.get(testBaseURL + testPath))
            .thenAnswer((_) async => http.Response('Server Error', 500));

        expect(sut.get(testPath), throwsA(isA<ServerErrorException>()));
      });

      test("with status code not mapped", () async {
        when(clientMock.get(testBaseURL + testPath))
            .thenAnswer((_) async => http.Response('Unauthorised', 505));

        expect(sut.get(testPath), throwsA(isA<FetchDataException>()));
      });
    });
  });
}

class TestObject {
  final String title;

  TestObject(this.title);

  TestObject.fromJSON(Map<String, dynamic> json) : title = json["title"];
}
