import 'package:good_start/src/shared/models/user-model-hive.dart';
import 'package:good_start/src/shared/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {

  final user$ = BehaviorSubject<User>();

  Box<User> _currentUserBox;
  Stream<BoxEvent> _currentUserBoxStream;


  AuthBloc() {
    _initBox().then((_){
      final User savedUser = _currentUserBox.getAt(0);
      if (savedUser != null) {
        user$.add(savedUser);
      }
      _currentUserBoxStream = _currentUserBox.watch();
    });
    
   _currentUserBoxStream.listen((BoxEvent event) {
     user$.add(event.value);
   });

  }

  void addUser(User user) {
    _currentUserBox.putAt(0, user);
  }

  void removeUser() {
    _currentUserBox.delete(0);
  }

  void dispose(){
    user$.close();
    _currentUserBox?.close();
  }


  Future<void> _initBox() async {
    _currentUserBox = await Hive.openBox(CurrentUserBox);
  }

}