class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://192.168.1.14:4000/";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  // auth
  static const String authenticate = baseUrl + "authenticate";

  //get user profile data
  static const String userProfile = baseUrl + "getProfile";

  //get inbox messages list data
  static const String inboxList = baseUrl + "getInbox";

  //get conversation messages list data
  static const String chatList = baseUrl + "getChat";

  //get dashboard data
  static const String dashboardData = baseUrl + "getDashboard";

  //get users list
  static const String usersList = baseUrl + "getUsers";
}
