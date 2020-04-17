import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19/IconPack/ajayistic_icons_icons.dart';
import 'package:covid19/Utils/ListAnimater.dart';
import 'package:covid19/Widgets/bar_chart.dart';
import 'package:covid19/Widgets/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert' show json;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RefreshController _refreshController = RefreshController();
  bool _isFetching = false;
  List _countriesData;
  List _countriesDataSearched;

  List<Widget> buildList() {
    return List.generate(
      _countriesDataSearched.length,
      (i) => FadeIn(
              1.3, InkWell(
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        (MediaQuery.of(context).size.width) * 0.07)),
                color: Color(0xFFF2F2FA),
                elevation: 0,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: (MediaQuery.of(context).size.width) * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(flex:1,child: SizedBox()),
                          SizedBox(height: 40,
                          width: 40,
                            child: Image.network('${_countriesDataSearched[i]['countryInfo']['flag']}')),
                            SizedBox(width: 20),
                          SizedBox(
                                                      child: AutoSizeText(
                              " " + (_countriesDataSearched[i]["country"]).toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF707070)),
                            ),
                          ),
                          Expanded(flex: 2, child: SizedBox()),
                        ],
                      ),
                    ),
                    Divider(
                        color: Colors.grey.shade300,
                        height: (MediaQuery.of(context).size.width) * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: SizedBox(
                        width: (MediaQuery.of(context).size.width) * 0.9,
                        height: (MediaQuery.of(context).size.width) * 0.7,
                        child: BarChart(data: [
                          ChartData(
                              name: "Cases",
                              amount: _countriesDataSearched[i]["cases"],
                              barColor: charts.ColorUtil.fromDartColor(
                                  Color(0xFF5579DB))),
                          ChartData(
                              name: "Recovered",
                              amount: _countriesDataSearched[i]["recovered"],
                              barColor: charts.ColorUtil.fromDartColor(
                                  Color(0xFF7DC161))),
                          ChartData(
                              name: "Deaths",
                              amount: _countriesDataSearched[i]["deaths"],
                              barColor: charts.ColorUtil.fromDartColor(
                                  Color(0xFFDB5579))),
                        ]),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(width: 35),
                            Text(
                              'Total : ',style: TextStyle(
                                                fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                    0.04,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF707070))
                            ),
                          ],
                        ),
                        SizedBox(
                            height: (MediaQuery.of(context).size.width) * 0.04),
                        Container(
                          margin: EdgeInsets.only(left: 26, right: 26),
                          height: (MediaQuery.of(context).size.width) * 0.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD6DCF4),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Cases',
                                            style: TextStyle(
                                                fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                    0.035,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF707070))),
                                        SizedBox(
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .width) *
                                                0.01),
                                        Text(
                                            _countriesDataSearched[i]["cases"]
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                    0.048,
                                                color: Color(
                                                  0xFF5579DB,
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD6DCF4),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Recovered',
                                            style: TextStyle(
                                                fontSize: (MediaQuery.of(context).size.width) *0.035,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF707070))),
                                        SizedBox(
                                            height: (MediaQuery.of(context).size.width) *0.01),
                                        Text(
                                            _countriesDataSearched[i]["recovered"].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (MediaQuery.of(context).size.width) *0.048,
                                                color: Color(0xFF5579DB,))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD6DCF4),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Deaths',
                                            style: TextStyle(
                                                fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                    0.035,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF707070))),
                                        SizedBox(
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .width) *
                                                0.01),
                                        Text(
                                            _countriesDataSearched[i]["deaths"]
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                    0.048,
                                                color: Color(
                                                  0xFF5579DB,
                                                ))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                          padding: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFD6DCF4),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 80.0,
                                margin:
                                    EdgeInsets.only(left: 15, right: 15, top: 5),
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Today : ',
                                                  style: TextStyle(
                                                      fontSize:
                                                          (MediaQuery.of(context)
                                                                  .size
                                                                  .width) *
                                                              0.04,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF707070))),
                                              SizedBox(
                                                  height: (MediaQuery.of(context)
                                                          .size
                                                          .width) *
                                                      0.01),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Cases',
                                                  style: TextStyle(
                                                      fontSize:
                                                          (MediaQuery.of(context)
                                                                  .size
                                                                  .width) *
                                                              0.04,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF707070))),
                                              Text(
                                                  _countriesDataSearched[i]
                                                          ["todayCases"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize:
                                                          (MediaQuery.of(context)
                                                                  .size
                                                                  .width) *
                                                              0.044,
                                                      color: Color(
                                                        0xFF5579DB,
                                                      ))),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Deaths',
                                                  style: TextStyle(
                                                      fontSize:
                                                          (MediaQuery.of(context)
                                                                  .size
                                                                  .width) *
                                                              0.04,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF707070))),
                                              Text(
                                                  _countriesDataSearched[i]
                                                          ["todayDeaths"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize:
                                                          (MediaQuery.of(context)
                                                                  .size
                                                                  .width) *
                                                              0.044,
                                                      color: Color(
                                                        0xFF5579DB,
                                                      ))),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 90,
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text('Active : ',
                                                style: TextStyle(
                                                    fontSize:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) *
                                                            0.04,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF707070))),
                                            Text(
                                                _countriesDataSearched[i]
                                                        ["active"]
                                                    .toString(),
                                                style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                    0.044,
                                                color: Color(
                                                  0xFF5579DB,
                                                ))),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text('Critical : ',
                                                style: TextStyle(
                                                    fontSize:
                                                        (MediaQuery.of(context)
                                                                .size
                                                                .width) *
                                                            0.04,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF707070))),
                                            Text(
                                                _countriesDataSearched[i]
                                                        ["critical"]
                                                    .toString(),
                                                style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                    0.044,
                                                color: Color(
                                                  0xFF5579DB,
                                                ))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            (MediaQuery.of(context).size.width) *
                                                0.02),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              'Cases Per One Million : ',
                                              style: TextStyle(
                                                  fontSize:
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .width) *
                                                          0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF707070)),
                                            ),
                                            Text(
                                                _countriesDataSearched[i]
                                                        ["casesPerOneMillion"]
                                                    .toString(),
                                                style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: (MediaQuery.of(context)
                                                        .size
                                                        .width) *
                                                    0.044,
                                                color: Color(
                                                  0xFF5579DB,
                                                ))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _fetchCountriesData() async {
    if(mounted){
      if (!_isFetching) {
      setState(() {
        _controller.clear();
        _isFetching = true;
      });
    }
      final response = await http.get("https://corona.lmao.ninja/v2/countries");
      if(mounted){
        if (response.statusCode == 200) {
        setState(() {
          _countriesData = json.decode(response.body);
          _countriesDataSearched = json.decode(response.body);
          _isFetching = false;
        });
      }
        _refreshController.refreshCompleted();
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Make sure you have internet connection.",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.orange,
          action: SnackBarAction(
            textColor: Colors.white,
            label: "Try Again",
            onPressed: _fetchCountriesData,
          ),
        ));
      }
    }
  }

  String _searchedText = '';

  @override
  void initState() {
    super.initState();
    // animationController = AnimationController(
    //   duration: Duration(milliseconds: 3000), vsync: this
    // );
    // animation = Tween(begin: 0.0, end: 1500.0).animate(animationController)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    // animationController.forward();
    _fetchCountriesData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Relatime ScreenSize
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final radius = screenWidth * 0.07;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
                  child: Scaffold(
            backgroundColor: Color(0xFFF2F2FA),
            body: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Hero(
                  tag: 'searchBar',
                  child: Container(
                    height: screenWidth * 0.17,
                    margin: EdgeInsets.only(left: 25.0, right: 25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      color: Color(0xFFD6DCF4),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 7.0),
                          child: Material(
                            color: Colors.transparent,
                            child: TextField(
                                controller: _controller,
                                cursorColor: Color(0xFF5579DB),
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontSize: ( screenWidth > 400 && screenWidth < 420 ) ? screenWidth*0.04 : screenWidth*0.055,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF707070)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Country',
                                  hintStyle: TextStyle(
                                      fontSize: ( screenWidth > 400 && screenWidth < 420 ) ? screenWidth*0.04 : screenWidth*0.055,
                                      fontWeight: FontWeight.bold),
                                ),
                                onChanged: (text) {
                                  text = text.toLowerCase();
                                  if (text == "") {
                                    setState(() {
                                      _countriesDataSearched = _countriesData;
                                      _searchedText = text;
                                    });
                                  } else {
                                    setState(() {
                                      _searchedText = text;
                                      _countriesDataSearched =
                                          _countriesDataSearched.where((country) {
                                        return country["country"]
                                            .toLowerCase()
                                            .contains(text);
                                      }).toList();
                                    });
                                  }
                                }),
                          ),
                        ),
                        Positioned(
                          right: 0.0,
                          child: GestureDetector(
                            onTap: () {
                              _searchedText = _searchedText.toLowerCase();
                              if (_searchedText == "") {
                                setState(() {
                                  _countriesDataSearched = _countriesData;
                                });
                              } else {
                                setState(() {
                                  _countriesDataSearched =
                                      _countriesDataSearched.where((country) {
                                    return country["country"]
                                        .toLowerCase()
                                        .contains(_searchedText);
                                  }).toList();
                                });
                              }

                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF5579DB),
                                borderRadius: BorderRadius.circular(radius),
                              ),
                              child: Center(
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                      icon: Icon(
                                        AjayisticIcons.a014_search,
                                        color: Colors.white,
                                      ),
                                      onPressed: null),
                                ),
                              ),
                              width: screenWidth * 0.23,
                              height: screenWidth * 0.17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: screenHeight * 0.82,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(radius),
                        topLeft: Radius.circular(radius)),
                    color: Color(0xFF5579DB),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: _isFetching
                        ? Container(
                            child: Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 5.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFF2F2FA)),
                                ),
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                          )
                        : SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            onRefresh: _fetchCountriesData,
                            child: CustomScrollView(
                              physics: BouncingScrollPhysics(),
                              slivers: [
                                SliverList(
                                    delegate:
                                        SliverChildListDelegate(buildList()))
                              ],
                            ),
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
