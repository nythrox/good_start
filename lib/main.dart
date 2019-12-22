import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:good_start/src/pages/authentication/views/authentication_page.dart';
import 'package:good_start/src/pages/home/home_page.dart';
import 'package:good_start/src/shared/bloc/auth_bloc.dart';
import 'package:good_start/src/shared/models/user-model-hive.dart';
import 'package:good_start/src/shared/styles/style.dart';
import 'package:good_start/src/shared/utils/constants/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(UserAdapter(), 0);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthBloc authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: appTheme,
        home: BlocProvider(
          blocs: [
            Bloc((i) => authBloc),
          ],
          child: StreamBuilder<User>(
            stream: authBloc.user$,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  print(snapshot.data.name);
                  return HomePage();
                }
                return AuthenticationPage();
              }
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            },
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
