// ignore_for_file: file_names
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tradpool/Core/usecases/params.dart';
import 'package:tradpool/features/register/data/models/create_user.dart';
import 'package:tradpool/features/register/domain/repositories/register_repository.dart';
import 'package:tradpool/features/register/domain/usecases/register_use_case.dart';

class MockPostRepository extends Mock implements RegisterRepository {}

void main() {
  RegisterUseCase usecase;
  MockPostRepository mockedregisterRepository;

  setUp(() {
    mockedregisterRepository = MockPostRepository();
    usecase = RegisterUseCase(mockedregisterRepository);
  });

  const String resultmatcher = "OTP sent successfully";

  test("should get the otp sent successfully from the repository", () async {
    // arrange
    when(mockedregisterRepository.createUser(any))
        .thenAnswer((_) async => const Right(resultmatcher));

    //act
    CreateUserModel createUserModel = const CreateUserModel(
        addressmodel: "",
        descriptionmodel: "",
        emailmodel: "",
        mobileNumbermodel: "",
        namemodel: "",
        receiveNotificationsmodel: true);
    final result = await usecase(Params(user: createUserModel));

    expect(result, const Right(resultmatcher));

    verify(mockedregisterRepository.createUser(createUserModel));
    verifyNoMoreInteractions(mockedregisterRepository);
  });
}
