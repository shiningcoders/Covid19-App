import 'package:covid19/Secret/admob.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  String _mapStyle;

  GoogleMapController _controller;
  bool isMapCreated = false;
  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   keywords: <String>['corona', 'covid19', 'health', 'shopping'],
  //   childDirected: false,
  //   designedForFamilies: false,
  //   gender: MobileAdGender.unknown,
  // );

  // InterstitialAd myInterstitial = InterstitialAd(
  //   adUnitId: interstitial_adUnitId,
  //   targetingInfo: targetingInfo,
  //   listener: (MobileAdEvent event) {
  //     print("InterstitialAd event is $event");
  //   },
  // );

  int total_cases = 0, recovered = 0, deaths = 0;
  bool isLoading = true, pinClicked = false;
  String countryName;
  List detailData = [];
  double lat = 0, long = 0;


  @override
  initState() {

    super.initState();
    
    _getCovidData();
    _getDetailedData();
    // myInterstitial
    //   ..load()
    //   ..show(
    //     anchorType: AnchorType.bottom,
    //     anchorOffset: 0.0,
    //     horizontalCenterOffset: 0.0,
    //   );

    
    rootBundle.loadString('assets/map_style.txt').then((string) {
    _mapStyle = string;
  });
  }

  @override
  void dispose() {
    // myInterstitial.dispose();
    //animationController.dispose();
    super.dispose();
  }


  List<Marker> allMarkers = [];

  void _getCovidData() async {
    setState(() {
      isLoading = true;
    });
    String url = countryName == null
        ? "https://covid19.mathdro.id/api"
        : "https://covid19.mathdro.id/api/countries/$countryName";
    http.Response data = await http.get(url);
    dynamic coronaData = jsonDecode(data.body);

    setState(() {
      total_cases = coronaData["confirmed"]["value"];
      recovered = coronaData["recovered"]["value"];
      deaths = coronaData["deaths"]["value"];
      isLoading = false;
    });
  }

  void _getDetailedData() async {
    String url = countryName == null
        ? "https://covid19.mathdro.id/api/confirmed"
        : "https://covid19.mathdro.id/api/countries/$countryName/confirmed";
    http.Response data = await http.get(url);
    dynamic coronaDetail = jsonDecode(data.body);
    setState(() {
      detailData = coronaDetail;
    });
    for (var location in detailData) {
      print('my:${location['long']}');
      allMarkers.add(
        Marker(
        markerId: MarkerId('my:${location['long']}'),
        draggable: false,
        onTap: () {
                  setState(() {
                    pinClicked = true;
                    lat = location["lat"];
                    long = location["long"];
                  });
                },
        position: LatLng(location['lat']!=null?location['lat'].toDouble():0, location['long']!=null?location['long'].toDouble():0),
        )
      );
    }
  }

  Widget showContainer() {
    print(lat.toString() + " " + long.toString());
    dynamic location = {};
    for (var country in detailData) {
      if (country["lat"] == lat && country["long"] == long) {
        location = country;
      }
    }

    // print(location);
    return Stack(
      children: <Widget>[
        Card(
          color: Color(0xfff2f2fa),
          elevation: 10.0,
          child: Container(
            width: 150.0,
            height: 100.0,
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                location["provinceState"] != null
                    ? Text(
                        "City: ${location["provinceState"]}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : location["countryRegion"] != null
                        ? Text(
                            "Country: ${location["countryRegion"]}",
                            style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                          )
                        : Text(''),
                location["confirmed"] != null
                    ? Text(
                        "Total Cases: ${location["confirmed"]}",
                        style: TextStyle(color: Colors.black),
                      )
                    : Text(''),
                location["recovered"] != null
                    ? Text(
                        "Recovered: ${location["recovered"]}",
                        style: TextStyle(color: Colors.black),
                      )
                    : Text(''),
                location["deaths"] != null
                    ? Text(
                        "Deaths: ${location["deaths"]}",
                        style: TextStyle(color: Colors.black),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: -9,
          child: Container(
            width: 25,
            decoration: BoxDecoration(
                color: Color(0xFF5679db),
                // borderRadius: ,
                shape: BoxShape.circle),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.close,
                color: Color(0xFFf2f2fa),
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  pinClicked = false;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
                          child: Scaffold(
                backgroundColor: Color(0xfff2f2fa),
                body: Center(
                    child: Image.asset(
                  'assets/loadingPage.png',
                  height: 180,
                  filterQuality: FilterQuality.medium,
                  fit: BoxFit.cover,
                )),
              ),
            ),
          )
        : SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
                          child: Scaffold(
                backgroundColor: Color(0xFFf2f2fa),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Corona Map',
                                style: TextStyle(
                                    color: Color(0xFF5679DB),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: EdgeInsets.only(
                            left: 6,
                            right: 6,
                            bottom: 6,
                          ),
                          child: Stack(
                            children: <Widget>[
                               GoogleMap(
                                 mapToolbarEnabled: false,

                 initialCameraPosition: CameraPosition(target: LatLng(20.5937, 78.9629)),
                 //markers: Set<Marker>.of(markers.values),
                 markers: Set.from(allMarkers),
                 onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  isMapCreated=true;
                  setState(() {_controller.setMapStyle(_mapStyle);});
                },
                               ),
                              pinClicked
                                  ? Positioned(
                                      top: 100,
                                      child: showContainer(),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
