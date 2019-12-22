import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:good_start/src/shared/models/user-model-hive.dart';
import 'package:good_start/src/shared/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase {
  final user$ = BehaviorSubject<User>();
  Future<Box<User>> _currentUserBox = Hive.openBox(CurrentUserBox);
  Future<Box<String>> _accessTokenBox = Hive.openBox(AccessTokenBox);
  Future<Box<String>> _refreshTokenBox = Hive.openBox(RefreshTokenBox);
  Stream<BoxEvent> currentUserBoxStream;

  AuthBloc() {
    _init();
  }

  Future<void> _init() async {
    currentUserBoxStream = (await _currentUserBox).watch();
    currentUserBoxStream.listen((BoxEvent event) {
      print('new event: '+event.value.toString());
      user$.add(event.value);
    });
    user$.add(await getCurrentUser());
  }

  Future<void> login(User user, String accessToken, String refreshToken) async {
    addUser(user);
    addAccessToken(accessToken);
    addRefreshToken(refreshToken);
  }

  Future<void> logout() async {
    await removeRefreshToken();
    await removeAccessToken();
    await removeUser();
  }

  Future<User> getCurrentUser() async {
    User savedUser;
    try {
      savedUser = (await _currentUserBox).getAt(0);
    } catch (e) {
      print("no logged in user");
      return null;
    }
    return savedUser;
  }

  Future<String> getAccessToken() async {
    String accessToken;
    try {
      accessToken = (await _accessTokenBox).getAt(0);
    } catch (e) {
      return null;
    }
    return accessToken;
  }

  Future<String> getRefreshToken() async {
    String refreshToken;
    try {
      refreshToken = (await _refreshTokenBox).getAt(0);
    } catch (e) {
      return null;
    }
    return refreshToken;
  }

  Future<void> addUser(User user) async {
    if (await getCurrentUser() != null)
      (await _currentUserBox).putAt(0, user);
    else
      (await _currentUserBox).add(user);
  }

  Future<void> addAccessToken(String accessToken) async {
    if (await getAccessToken() != null)
      (await _accessTokenBox).putAt(0, accessToken);
    else
      (await _accessTokenBox).add(accessToken);
  }

  Future<void> addRefreshToken(String refreshToken) async {
    if (await getRefreshToken() != null)
      (await _refreshTokenBox).putAt(0, refreshToken);
    else
      (await _refreshTokenBox).add(refreshToken);
  }

  Future<void> removeUser() async {
    if (await getCurrentUser() != null) (await _currentUserBox).deleteAt(0);
  }
  
  Future<void> removeAccessToken() async {
    if (await getAccessToken() != null) (await _accessTokenBox).deleteAt(0);
  }

  Future<void> removeRefreshToken() async {
    if (await getRefreshToken() != null) (await _refreshTokenBox).deleteAt(0);
  }

  @override
  Future<void> dispose() async {
    user$.close();
    (await _accessTokenBox).close();
    (await _refreshTokenBox).close();
    (await _currentUserBox).close();
  }
}
