class BaseURL {
  // static String domain = 'http://192.168.1.4:3000/';
  // static String domain = 'http://wisata.test/';
  static String domain = 'http://143.198.206.223:8002/';
  static String baseURL = "${domain}api/";

  //Auth
  static String urlLogin = "${baseURL}login";
  static String urlRegister = "${baseURL}register";
  static String urlLogout = "${baseURL}auth/logout";
  static String urlRefreshToken = "${baseURL}auth/refresh-token";

  //Toruism Place
  static String urlTourismPlace = "${baseURL}tourism-places";
  static String urlCategory = "${baseURL}categories";
}
