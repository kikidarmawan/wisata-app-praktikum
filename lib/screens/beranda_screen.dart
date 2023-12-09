import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_app/base_url.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/models/category_response.dart';
import 'package:wisata_app/screens/dashboard_screen.dart';
import 'package:wisata_app/screens/login_screen.dart';
import 'package:wisata_app/screens/main_screen.dart';
import 'package:wisata_app/utils/contants.dart';
import 'package:wisata_app/utils/page_transtion.dart';
import 'package:wisata_app/widgets/shimmer.dart';
import 'package:wisata_app/widgets/shimmer_dark.dart';

import 'package:http/http.dart' as http;
// import 'package:wisata_app/widgets/style.dart';
// import 'package:http/http.dart' as http;

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});
  @override
  _BerandaScreenState createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  // int _current = 0;
  String? name, email, saldo, phone, plan, profile, debit, credit;
  // String _name = '';
  // String _email = '';
  int countNotif = 0;
  int? intDebit, intCredit;
  bool loading = false;

  List<Category> categoryList = [];
  // List<PromoModel> _promo = [];
  // List<ArticleModel> _article = [];

  Future<void> _fetchCategory() async {
    final String apiUrl = BaseURL.urlCategory;
    final accessToken = await SessionManager.getToken();

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final CategoryResponse categoryResponse =
            CategoryResponse.fromJson(responseData);

        // Accessing properties of the model
        print('Status: ${categoryResponse.message}');

        // Accessing each tourism place
        setState(() {
          categoryList = categoryResponse.data;
        });

        print(responseData);
      } else {
        // print message
        print('Request failed with status: ${response.body}.');
        // Handle errors
        print(
            'Failed to fetch tourism places. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during fetching users: $e');
    }
  }
  // void getPromo() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   var token = _prefs.getString('token');
  //   final response =
  //       await http.get(Uri.parse(IpClass().getip() + '/api/promos'), headers: {
  //     HttpHeaders.acceptHeader: "application/json",
  //     HttpHeaders.authorizationHeader: "Bearer " + token!,
  //   });
  //   var res = json.decode(response.body);
  //   if (mounted) {
  //     setState(() {
  //       for (var data in res['data']) {
  //         _promo.add(PromoModel.fromJson(data));
  //       }
  //     });
  //   }
  // }

  // void getArticle() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   var token = _prefs.getString('token');
  //   final response = await http
  //       .get(Uri.parse(IpClass().getip() + '/api/articles'), headers: {
  //     HttpHeaders.acceptHeader: "application/json",
  //     HttpHeaders.authorizationHeader: "Bearer " + token!,
  //   });
  //   var res = json.decode(response.body);
  //   if (mounted) {
  //     setState(() {
  //       for (var data in res['data']) {
  //         _article.add(ArticleModel.fromJson(data));
  //       }
  //     });
  //   }
  // }

  Future home() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var authName = prefs.getString('name');
    var authEmail = prefs.getString('email');

    // name = authName;
    // email = authEmail;

// set state to _name
    setState(() {
      name = authName;
      email = authEmail;
    });

    if (token == null) {
      // munculkan flutter toast
      // Fluttertoast.showToast(
      //     msg: "Maaf, anda tidak terotentikasi. Silahkan login Ulang",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.grey[200],
      //     textColor: Colors.black54,
      //     fontSize: 16.0);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      // munculkan flutter toast
      // Fluttertoast.showToast(
      //     msg: "Selamat datang, $name",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.grey[200],
      //     textColor: Colors.black54,
      //     fontSize: 16.0);
      print('token home: $token');
    }
  }

  void homeStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var authName = prefs.getString('name');
    var authEmail = prefs.getString('email');

    // name = authName;
    // email = authEmail;
    setState(() {
      name = authName;
      email = authEmail;
    });

    if (token == null) {
      // munculkan flutter toast
      // Fluttertoast.showToast(
      //     msg: "Maaf, anda tidak terotentikasi. Silahkan login Ulang",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.grey[200],
      //     textColor: Colors.black54,
      //     fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      if (prefs.getBool('isLogin') == true) {
        // Fluttertoast.showToast(
        //     msg: "Selamat datang, $name",
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.grey[200],
        //     textColor: Colors.black54,
        //     fontSize: 16.0);
      }

      prefs.setBool('isLogin', false);
      home();
      print('token home start: $token');
      print('name home start: $name');
      print('email home start: $name');
    }
  }

  @override
  void initState() {
    homeStart();
    _fetchCategory();
    // getPromo();
    // getArticle();
    super.initState();

    print('initstate');
    // print('auth user: $name');
    // print('auth email: $email');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Color(0xFF013380),
          statusBarIconBrightness:
              Brightness.light //or set color with: Color(0xFF0000FF)
          ),
    );
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: width,
            height: 95,
            padding: EdgeInsets.only(top: 49, left: 20, right: 20, bottom: 10),
            color: primaryColor,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/bg-head-home.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset('assets/images/jokka-home-logo.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          loading == true
                              ? Shimmer(
                                  height: 12,
                                  width: 30,
                                )
                              : plan == 'Premium Member'
                                  ? Row(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/premium.png',
                                          width: 12,
                                          height: 12,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            'Premium Member',
                                            style: TextStyle(
                                                fontFamily: 'Archivo',
                                                fontStyle: FontStyle.normal,
                                                fontSize: 12,
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Text(
                                        'Selamat Pagi',
                                        style: TextStyle(
                                            fontFamily: 'Archivo',
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                      ),
                                    ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: loading == true
                                ? Shimmer(
                                    height: 20,
                                    width: 50,
                                  )
                                : Text(name == null ? '' : name!,
                                    style: TextStyle(
                                        fontFamily: 'Archivo',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.upToDown,
                                child: DashboardScreen()));
                      },
                      child: countNotif == 1
                          ? Image.asset(
                              'assets/images/notif.png',
                              width: 40,
                              height: 40,
                            )
                          : Image.asset(
                              'assets/images/notif-blank.png',
                              width: 40,
                              height: 40,
                            ),
                    ),
                    loading == true
                        ? Shimmer(
                            height: 40,
                            width: 40,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: profile == null
                                ? Image.asset(
                                    'assets/images/user.png',
                                    height: 40.0,
                                    width: 40.0,
                                  )
                                : Image.asset(
                                    BaseURL.domain + 'assets/images/user.png',
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: home,
              color: Color(0xFF0064FE),
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (loading != true) {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: DashboardScreen()));
                      }
                    },
                    child: Container(
                      width: width,
                      height: 125,
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 20),
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage("assets/images/bg-home-down.png"),
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      color: primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text('Saldo Dompet',
                                      style: TextStyle(
                                          fontFamily: 'Archivo',
                                          fontSize: 14,
                                          color: Colors.white))),
                              loading == true
                                  ? Shimmer(
                                      height: 50,
                                      width: 150,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text('Rp. ',
                                              style: TextStyle(
                                                  fontFamily: 'Archivo',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          Text("0",
                                              style: TextStyle(
                                                  fontFamily: 'Archivo',
                                                  fontSize: 28,
                                                  height: 0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                          loading == true
                              ? Shimmer(
                                  height: 50,
                                  width: 50,
                                )
                              : Row(
                                  children: [
                                    Container(
                                      // width: 200,
                                      height: 60,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: bgLightColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.wallet,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          Text(
                                            "Topup Saldo",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                  // loadingreward == true
                  //     ? Shimmer(
                  //         width: width,
                  //         height: 30,
                  //       )
                  //     : Container(
                  //         child: CountdownTimer(
                  //           endTime: _reward.startDate == null
                  //               ? DateTime.now().millisecondsSinceEpoch +
                  //                   3200000
                  //               : DateTime.parse(_reward.endDate.toString())
                  //                   .millisecondsSinceEpoch,
                  //           onEnd: () {},
                  //           widgetBuilder: (_, CurrentRemainingTime? time) {
                  //             if (time == null) {
                  //               return Center(
                  //                   child: Text(
                  //                 '',
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.w800),
                  //               ));
                  //             }
                  //             return Container(
                  //               width: width,
                  //               alignment: Alignment.center,
                  //               padding: const EdgeInsets.all(10),
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   boxShadow: [
                  //                     BoxShadow(
                  //                       color: Colors.black.withOpacity(0.25),
                  //                       offset: Offset(0, 5),
                  //                       blurRadius: 6,
                  //                     ),
                  //                   ]),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       Text(
                  //                         'REWARD',
                  //                         style: TextStyle(
                  //                             fontSize: 14,
                  //                             color: Colors.black,
                  //                             fontFamily: 'Archivo',
                  //                             fontWeight: FontWeight.w800),
                  //                       ),
                  //                       const SizedBox(width: 5),
                  //                       Container(
                  //                         padding: const EdgeInsets.all(3),
                  //                         color:
                  //                             Color.fromARGB(255, 23, 27, 245),
                  //                         child: Text(
                  //                           '${time.days == null ? '00' : time.days.toString().padLeft(2, "0")}',
                  //                           style: TextStyle(
                  //                               fontSize: 14,
                  //                               color: Colors.white,
                  //                               fontFamily: 'Archivo',
                  //                               fontWeight: FontWeight.w800),
                  //                         ),
                  //                       ),
                  //                       SizedBox(width: 5),
                  //                       Text(
                  //                         ':',
                  //                         style: TextStyle(
                  //                             fontSize: 14,
                  //                             color: Colors.black,
                  //                             fontFamily: 'Archivo',
                  //                             fontWeight: FontWeight.w800),
                  //                       ),
                  //                       SizedBox(width: 5),
                  //                       Container(
                  //                         padding: const EdgeInsets.all(3),
                  //                         color:
                  //                             Color.fromARGB(255, 23, 27, 245),
                  //                         child: Text(
                  //                           '${time.hours == null ? '00' : time.hours.toString().padLeft(2, "0")}',
                  //                           style: TextStyle(
                  //                               fontSize: 14,
                  //                               color: Colors.white,
                  //                               fontFamily: 'Archivo',
                  //                               fontWeight: FontWeight.w800),
                  //                         ),
                  //                       ),
                  //                       SizedBox(width: 5),
                  //                       Text(
                  //                         ':',
                  //                         style: TextStyle(
                  //                             fontSize: 14,
                  //                             color: Colors.black,
                  //                             fontFamily: 'Archivo',
                  //                             fontWeight: FontWeight.w800),
                  //                       ),
                  //                       SizedBox(width: 5),
                  //                       Container(
                  //                         padding: const EdgeInsets.all(3),
                  //                         color:
                  //                             Color.fromARGB(255, 23, 27, 245),
                  //                         child: Text(
                  //                           '${time.min == null ? '00' : time.min.toString().padLeft(2, "0")}',
                  //                           style: TextStyle(
                  //                               fontSize: 14,
                  //                               color: Colors.white,
                  //                               fontFamily: 'Archivo',
                  //                               fontWeight: FontWeight.w800),
                  //                         ),
                  //                       ),
                  //                       SizedBox(width: 5),
                  //                       Text(
                  //                         ':',
                  //                         style: TextStyle(
                  //                             fontSize: 14,
                  //                             color: Colors.black,
                  //                             fontFamily: 'Archivo',
                  //                             fontWeight: FontWeight.w800),
                  //                       ),
                  //                       SizedBox(width: 5),
                  //                       Container(
                  //                         padding: const EdgeInsets.all(3),
                  //                         color:
                  //                             Color.fromARGB(255, 23, 27, 245),
                  //                         child: Text(
                  //                           '${time.sec == null ? '00' : time.sec.toString().padLeft(2, "0")}',
                  //                           style: TextStyle(
                  //                               fontSize: 14,
                  //                               color: Colors.white,
                  //                               fontFamily: 'Archivo',
                  //                               fontWeight: FontWeight.w800),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   InkWell(
                  //                     onTap: () {
                  //                       if (_reward.endDate != null) {
                  //                         Navigator.push(
                  //                             context,
                  //                             MaterialPageRoute(
                  //                                 builder: (context) =>
                  //                                     RewardScreen(
                  //                                       reward: _reward.data,
                  //                                     )));
                  //                       }
                  //                     },
                  //                     child: Row(
                  //                       children: [
                  //                         Text(
                  //                           'Lihat Reward',
                  //                           style: TextStyle(
                  //                               fontSize: 14,
                  //                               color: Colors.black,
                  //                               fontFamily: 'Archivo',
                  //                               fontWeight: FontWeight.w800),
                  //                         ),
                  //                         const SizedBox(width: 5),
                  //                         Icon(
                  //                           Icons.arrow_forward_ios,
                  //                           size: width * 0.03,
                  //                           color: Colors.black,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           },
                  //           endWidget: Center(
                  //               child: Text(
                  //             '',
                  //             style: TextStyle(
                  //                 fontSize: 14,
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.w800),
                  //           )),
                  //         ),
                  //       ),
                  if (loading == true)
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 320,
                      width: width,
                      color: Colors.white,
                      padding: EdgeInsets.all(5),
                      child: GridView(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0),
                        children: <Widget>[
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                          ShimmerDark(
                            width: 53,
                            height: 84,
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 320,
                      width: width,
                      color: Colors.white,
                      padding: EdgeInsets.all(5),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0),
                        children: categoryList.isNotEmpty
                            ? categoryList
                                .map((e) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: MainScreen(
                                                  idCategory: e.id,
                                                  nameCategory: e.name,
                                                )));
                                      },
                                      child: Container(
                                        width: 53,
                                        height: 84,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.network(e.icon,
                                                  fit: BoxFit.cover),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(e.name,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    fontFamily: 'Archivo',
                                                    fontWeight:
                                                        FontWeight.w500))
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()
                            : [],
                      ),
                    ),
                  loading == true
                      ? Container(
                          height: 160,
                          width: width,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ShimmerDark(
                                height: 120,
                                width: 120,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 250,
                          width: width,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    "Tontonan Terbaru",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Wrap(
                                  spacing: 20,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 250,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/tonton1.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 250,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/tonton2.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                  Container(
                    width: width,
                    height: 12,
                    color: Colors.grey[100],
                  ),
                  Container(
                    width: width,
                    height: 320,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Merchant Terdekat",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Wrap(
                              spacing: 20,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/merchant1.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Sweat Leaf Coffee",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: 'Archivo',
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Coffee And Rosto",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "4.6 km",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/merchant2.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("De Remise",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: 'Archivo',
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Modern Apparel",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "4.6 km",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/merchant1.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Sweat Leaf Coffee",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: 'Archivo',
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Coffee And Rosto",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "4.6 km",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: 12,
                    color: Colors.grey[100],
                  ),
                  Container(
                    width: width,
                    height: 320,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Artikel Terkait",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Wrap(
                              spacing: 20,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/artikel1.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Example Article Number 1",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: 'Archivo',
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Lorem ipsum dolor sit amet",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/artikel2.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Example Article Number 2",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: 'Archivo',
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Lorem Ipsum dolor sit amet",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  // }
}
