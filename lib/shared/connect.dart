import 'package:good_start/shared/model/current_user.dart';
import 'package:hasura_connect/hasura_connect.dart';

class Connect {
  HasuraConnect hasuraConnect = HasuraConnect("https://good-start.herokuapp.com/v1/graphql");

}