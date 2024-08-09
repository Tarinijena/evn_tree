class ApiEndPoint {
  //  flutter build apk --flavor dev -t lib/flavors/dev/dev_main.dart (build command)

  static bool isDev = true;

  static String baseUrl = (isDev) ? "http://128.199.18.223:8080/evntree/api/v1" : "http://128.199.18.223:8080/evntree/api/v1";

  static String signUpUrl(String userId) => "$baseUrl/umt/public/login-demo?userName=$userId";

  static String citiesUrl= "$baseUrl/event/master/cities";
  static String categoryLst = "$baseUrl/event/master/eventCategories";

  static String signUrl="$baseUrl/umt/public/signup-user";
}
