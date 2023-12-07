import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wisata_app/base_url.dart';
import 'package:wisata_app/helper/session_manager.dart';
import 'package:wisata_app/models/tourism_place_response.dart';
import 'package:wisata_app/screens/detail_screen.dart';
import 'package:wisata_app/utils/contants.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TourismPlace> tourismPlaceList = [];

  @override
  void initState() {
    super.initState();
    _fetchPlace();
  }

  Future<void> _fetchPlace() async {
    final String apiUrl = BaseURL.urlTourismPlace;

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vacations'),
        backgroundColor: primaryColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final TourismPlace place = tourismPlaceList[index];
          final String imageUrl = place.imageAsset;
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(place: place);
              }));
            },
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 1, child: Image.network(imageUrl)),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            place.name,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(place.location),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: tourismPlaceList.length,
      ),
    );
  }
}
