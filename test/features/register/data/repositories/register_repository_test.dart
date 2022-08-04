import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tradpool/Core/error/exceptions.dart';
import 'package:tradpool/core/error/failures.dart';

import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/features/register/data/datasources/register_remote_data.dart';
import 'package:tradpool/features/register/data/models/create_user.dart';
import 'package:tradpool/features/register/data/repositories/register_repositoryimp.dart';

class MockedRemoteDataSource extends Mock implements RegisterRemoteData {}

class MockedNetworkInfo extends Mock implements NetworkInf {}

void main() {
  RegisterRepositoryImpl registerRepository;
  MockedNetworkInfo mockedNetworkInfo;
  MockedRemoteDataSource mockedRemoteDataSource;
  setUp(() {
    mockedRemoteDataSource = MockedRemoteDataSource();
    mockedNetworkInfo = MockedNetworkInfo();
    registerRepository =
        RegisterRepositoryImpl(mockedNetworkInfo, mockedRemoteDataSource);
  });

  group('register the user ', () {
    const registermodel = CreateUserModel(
        addressmodel: "",
        descriptionmodel: "",
        emailmodel: "",
        mobileNumbermodel: "",
        namemodel: "",
        receiveNotificationsmodel: true);

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        when(mockedNetworkInfo.isConnected).thenAnswer((_) async => true);
        String result = "otp sent successfully";
        // arrange

        when(mockedRemoteDataSource.createuser(any))
            .thenAnswer((_) async => result);

        // act
        final resultt = await registerRepository.createUser(registermodel);
        // assert
        verify(mockedRemoteDataSource.createuser(registermodel));
        expect(resultt, equals(const Right("otp sent successfully")));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockedNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockedRemoteDataSource.createuser(any))
            .thenThrow(ServerException());
        // act
        final result = await registerRepository.createUser(registermodel);
        // assert
        verify(mockedRemoteDataSource.createuser(registermodel));

        expect(result, equals(Left(ServerFailure(ServerException().error))));
      },
    );
  });
}
