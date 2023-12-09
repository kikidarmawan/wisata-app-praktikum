import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wisata_app/base_url.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/models/tourism_place_response.dart';
import 'package:wisata_app/screens/detail_screen.dart';
import 'package:wisata_app/utils/contants.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  final String idCategory;
  final String nameCategory;

  const MainScreen(
      {Key? key, required this.idCategory, required this.nameCategory})
      : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TourismPlace> tourismPlaceList = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlace();
  }

  Future<void> _fetchPlace() async {
    final String apiUrl =
        BaseURL.urlTourismPlace + '?category_id=' + widget.idCategory;

    final accessToken = await SessionManager.getToken();

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final TourismPlaceResponse tourismResponse =
            TourismPlaceResponse.fromJson(responseData);

        // Accessing properties of the model
        print('Status: ${tourismResponse.status}');
        print('Message: ${tourismResponse.message}');

        // Accessing each tourism place
        setState(() {
          tourismPlaceList = tourismResponse.data;
        });
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
    } // finally
    finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nameCategory),
        backgroundColor: primaryColor,
      ),
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : tourismPlaceList.isNotEmpty
              ? ListView.builder(
                  itemCount: tourismPlaceList.length,
                  itemBuilder: (context, index) {
                    final TourismPlace tourismPlace = tourismPlaceList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              place: tourismPlace,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                tourismPlace.imageAsset,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      tourismPlace.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      tourismPlace.location,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      tourismPlace.openDays,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      tourismPlace.openTime,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text('Data Kosong')),
    );
  }
}
