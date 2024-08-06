class ApiEndPoint {
  //  flutter build apk --flavor dev -t lib/flavors/dev/dev_main.dart (build command)

  static bool isDev = true;

  static String baseUrl = (isDev) ? "http://128.199.18.223:8080/evntree/api/v1/" : "http://128.199.18.223:8080/evntree/api/v1";

  static String signUpUrl(String userId) => "$baseUrl/umt/public/login-demo?userName=$userId";
}
