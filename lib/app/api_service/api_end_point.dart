class ApiEndPoint {
  //  flutter build apk --flavor dev -t lib/flavors/dev/dev_main.dart (build command)

  static bool isDev = true;

  static String baseUrl = (isDev) ? "http://128.199.18.223:8080/evntree/api/v1" : "http://128.199.18.223:8080/evntree/api/v1";

  static String signUpUrl(String userId) => "$baseUrl/umt/public/login-demo?userName=$userId";

  static String citiesUrl= "$baseUrl/event/master/cities";
  static String categoryLst = "$baseUrl/event/master/eventCategories";

  static String signupUser="$baseUrl/umt/public/signup-user";

  static String signUpVerify(String otpNumber,String emailId)=> "$baseUrl/umt/public/signup-verify?otp=$otpNumber&userName=$emailId";

  static String loginVerify(String userName,String userPassword)=>"$baseUrl/umt/public/login?userName=$userName&password=$userPassword";

  static String getUserProfile = "$baseUrl/umt/get-user-details";

}
