import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:good_start/src/pages/authentication/views/authentication_page.dart';
import 'package:good_start/src/pages/home/home_page.dart';
import 'package:good_start/src/shared/bloc/auth_bloc.dart';
import 'package:good_start/src/shared/models/user-model-hive.dart';
import 'package:good_start/src/shared/styles/style.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: appTheme,
        home: BlocProvider(
          blocs: [
            Bloc((i) => AuthBloc()),
          ],
          child: AuthenticationPage(),
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
