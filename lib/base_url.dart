class BaseURL {
  // static String domain = 'http://192.168.1.4:3000/';
  static String domain = 'http://192.168.100.215:3000/';
  static String baseURL = "${domain}api/";

  //Auth
  static String urlLogin = "${baseURL}auth/login";
  static String urlRegister = "${baseURL}auth/register";
  static String urlLogout = "${baseURL}auth/logout";
  static String urlRefreshToken = "${baseURL}auth/refresh-token";

  //Toruism Place
  static String urlTourismPlace = "${baseURL}tourism-place";
}
