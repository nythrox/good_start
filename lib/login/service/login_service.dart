import 'package:good_start/shared/connect.dart';
import 'package:good_start/shared/model/current_user.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:uuid/uuid.dart';

class LoginService {
  final connection = Connect();
  final snapshots = <Snapshot>[];

  Stream<UserModel> currentUser() {
    try {
      String query = """
          {
          users {
            user_id
            user_email
            client {
              client_id
              client_name
              client_cpf
              client_birthday
            }
          }
        }
        """;
      final queryStream = connection.hasuraConnect.subscription(query,
          variables: {"user_id": ""}).map((d) => UserModel.fromJson(d));

      snapshots.add(queryStream);

      return queryStream.stream;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> deleteUser(Uuid userId) async {
    try {
      String query = """
          deleteUser($userId: uuid!){
          delete_users(where: {user_id: {_eq: "$userId"}}) {
            affected_rows
          }
        }
      """;

      return await connection.hasuraConnect.mutation(query, variables: {
        "user_id": userId
      });
    }  catch (e) {
      rethrow;
    }
  }



  void dispose() {
    snapshots.forEach((e) => e.close());
  }
}
