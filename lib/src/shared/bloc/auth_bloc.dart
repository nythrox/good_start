import 'package:good_start/src/shared/models/user-model-hive.dart';
import 'package:good_start/src/shared/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  final user$ = BehaviorSubject<User>();

  Future<Box<User>> _currentUserBox = Hive.openBox(CurrentUserBox);
  Future<Box<String>> _accessTokenBox = Hive.openBox(AccessTokenBox);
  Future<Box<String>> _refreshTokenBox = Hive.openBox(RefreshTokenBox);
  Stream<BoxEvent> currentUserBoxStream;

  AuthBloc() {
    _init();
  }

  Future<void> _init() async {
    final User savedUser = (await _currentUserBox).getAt(0);
    if (savedUser != null) {
      user$.add(savedUser);
    }
    currentUserBoxStream = (await _currentUserBox).watch();

    currentUserBoxStream.listen((BoxEvent event) {
      user$.add(event.value);
    });
  }

  Future<void> addUser(User user) async {
    print(user);
    (await _currentUserBox).putAt(0, user);
  }

  Future<void> removeUser() async {
    (await _currentUserBox).delete(0);
  }

  Future<void> addAccessToken(String accessToken) async {
    print(accessToken);
    (await _accessTokenBox).putAt(0, accessToken);
  }

  Future<void> addRefreshToken(String refreshToken) async {
    print(refreshToken);
    (await _refreshTokenBox).putAt(0, refreshToken);
  }

  Future<void> removeAccessToken() async {
    (await _accessTokenBox).deleteAt(0);
  }

  Future<void> removeRefreshToken() async {
    (await _refreshTokenBox).deleteAt(0);
  }

  Future<void> dispose() async {
    user$.close();
    (await _accessTokenBox).close();
    (await _refreshTokenBox).close();
    (await _currentUserBox).close();
  }
}
