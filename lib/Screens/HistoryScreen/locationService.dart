import 'package:mapsandnavigationflutter/Screens/HistoryScreen/DatabaseHandler.dart';


class LocationService {
  DatabaseHandler _handler = DatabaseHandler();

  Future<int> addUser(String SourceLocation, String DestinationLocation,double SourceLog,double SourceLath,double DestinationLog, double DestinationLath) async {
    User newUser = User(SourceLocation: SourceLocation, DestinationLocation: DestinationLocation,SourceLog: SourceLog,SourceLath: SourceLath,DestinationLog :DestinationLog,DestinationLath :DestinationLath);
    int result = await _handler.addUser(newUser);
    return result;
  }

  Future<int> updateUser(User user) async {
    int result = await _handler.updateUser(user);
    return result;
  }

  Future<int> deleteUser(int id) async {
    int result = await _handler.deleteUser(id);
    return result;
  }
  Future<int> deleteAllUser() async {
    int result = await _handler.deleteAllUser();
    return result;
  }
  Future<List<User>> getUsers() async {
    List<User> users = await _handler.getUsers();
    return users;
  }
}
