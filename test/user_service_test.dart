import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shorty/src/services/service_locator.dart';
import 'package:shorty/src/services/user/user_service.dart';
import 'package:shorty/src/services/user/user_service_implementation.dart';
import 'package:shorty/src/services/user_storage/user_storage_service.dart';

class MockUserStorageService extends Mock implements UserStorageService {}

void main() {
  setUpAll(() {
    setupServiceLocator();
    serviceLocator.allowReassignment = true;
  });

  group("UserService", () {
    final mockUserStorageService = MockUserStorageService();
    
    test('Constructing Service should find correct dependencies', () {
    var userServiceImplementation = serviceLocator<UserService>();
    expect(userServiceImplementation , isNotNull);
  });

    test("should return true if the shouldDisplayOnBoardingScreen not seted",
        () {
      when(mockUserStorageService.getFlag).thenAnswer((_) => true);
      serviceLocator.registerLazySingleton<UserStorageService>(
          () => mockUserStorageService);
      final userServiceImpl = UserServiceImplementation();
      final shouldDisplayOnBoardingScren = userServiceImpl.getOnBoardingFlag();

      expect(shouldDisplayOnBoardingScren, isTrue);
    });

    test("should return false if the shouldDisplayOnBoardingScreen was seted",
        () {
      when(mockUserStorageService.getFlag).thenAnswer((_) => false);
      serviceLocator.registerLazySingleton<UserStorageService>(
          () => mockUserStorageService);
      final userServiceImpl = UserServiceImplementation();
      final shouldDisplayOnBoardingScren = userServiceImpl.getOnBoardingFlag();
  
      expect(shouldDisplayOnBoardingScren, isFalse);
    });
  });
}
