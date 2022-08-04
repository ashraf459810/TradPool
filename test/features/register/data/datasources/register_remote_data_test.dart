import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:tradpool/Core/error/exceptions.dart';
import 'package:tradpool/features/register/data/datasources/register_remote_data.dart';
import 'package:tradpool/features/register/data/models/create_user.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  RegisterRemoteDateImpl remotedataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remotedataSource = RegisterRemoteDateImpl(mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'),
            body: createUserToJson(const CreateUserModel(
                addressmodel: "",
                descriptionmodel: "",
                emailmodel: "",
                mobileNumbermodel: "",
                namemodel: "",
                receiveNotificationsmodel: true))))
        .thenAnswer((_) async => http.Response('otp sent successfully', 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers'),
            body: createUserToJson(const CreateUserModel(
                addressmodel: "",
                descriptionmodel: "",
                emailmodel: "",
                mobileNumbermodel: "",
                namemodel: "",
                receiveNotificationsmodel: true))))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('register the user', () {
    const result = 'otp sent successfully';
    CreateUserModel createUserModel = const CreateUserModel(
        addressmodel: "",
        descriptionmodel: "",
        emailmodel: "",
        mobileNumbermodel: "",
        namemodel: "",
        receiveNotificationsmodel: true);

    test(
      '''should perform a post request on a URL with create model
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        remotedataSource.createuser(createUserModel);
        // assert
        verify(mockHttpClient.post(
            Uri.parse('http://159.89.51.204:8080/tradepool/client/create'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: createUserToJson(createUserModel)));
      },
    );

    test(
      'should return otp sent successfully with the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result1 = await remotedataSource.createuser(createUserModel);
        // assert
        expect(result1, equals(result));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = remotedataSource.createuser(createUserModel);
        // assert
        expect(() => call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
