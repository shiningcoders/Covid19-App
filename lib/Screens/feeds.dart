//Fetch and display feeds

//import 'package:covid19/Secret/admob.dart';
import 'package:covid19/Utils/ListAnimater.dart';
import 'package:covid19/Utils/networkHelper.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class FeedsPage extends StatefulWidget {
  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  Future<List> getData() async {
    NetworkHelper covidData = NetworkHelper(
        'http://newsapi.org/v2/top-headlines?country=in&q=corona&sortBy=publishedAt&apiKey=d9fa391aacfe428e81b8c6002ea8a507');
    var covidNews = await covidData.getData();
    var articles = covidNews['articles'];
    //print(articles);

    return articles;
  }

  //Admob Ad implementation_____________________________________

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

  void initState() {
    super.initState();

    //Interstitial Ad properties and initialisation
    //  myInterstitial
    //   ..load()
    //   ..show(
    //     anchorType: AnchorType.bottom,
    //     anchorOffset: 0.0,
    //     horizontalCenterOffset: 0.0,
    //   );
      getData();
  }

  void dispose() {

    //InterstitialAd  dispose
    //myInterstitial.dispose();
    super.dispose();
  }

  //Page Refresh method
  Future<Null> refresh() async {
    await getData();
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
                      child: Scaffold(
            backgroundColor: Color(0xFFf2f2fa),
            //Display Loading Image if Feeds Loading
            body: FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(
                            child: Image.asset(
                      'assets/loadingPage.png',
                      height: 180,
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.cover,
                    )));
                  } else {
                    //Display Feeds if Feeds loaded
                    return Scaffold(
                      backgroundColor: Color(0xFFf2f2fa),
                      body: Stack(
                        children: <Widget>[

                          //______________________Header______________________
                          Container(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Corona Feeds',
                                    style: TextStyle(
                                        color: Color(0xFF5679DB),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24)),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(height: 100),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: refresh,
                                  color: Color(0xFF5679DB),
                                  //Feeds builder Method
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: GestureDetector(
                                            //Launch feed in In-App WebView
                                            onTap: () => launch(snapshot.data[index]
                                                        ['url'], forceWebView: true),
                                            child: FeedCard(
                                              image: snapshot.data[index]
                                                  ['urlToImage'],
                                              title: snapshot.data[index]['title'],
                                              description: snapshot.data[index]
                                                  ['description'],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                })),
          ),
    );
  }
}


//FeedCard : takes (title, description & image to display)
class FeedCard extends StatelessWidget {
  FeedCard({
    @required this.title,
    @required this.description,
    @required this.image,
  });
  String title;
  String description;
  String image;
  @override
  Widget build(BuildContext context) {
    return FadeIn( 1.0,
    Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFF6F8EE4),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 170.0,
              margin: EdgeInsets.only(left: 0, right: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                //Display fetched image (if there) otherwise loading image
                image: DecorationImage(
                    image: image != null ?
                        NetworkImage(image)
                        : AssetImage('assets/feedLoading.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Divider(
              color: Color(0xFFF2F2F2),
            ),
            //Title__________________________
            Text(
              title != null ? title : '',
              style: TextStyle(
                  color: Color(0xFFf2f2f2),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(height: 5),
            //Description____________________
            Text(description != null ? description : '',
                style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ],
        ),
      ),
    );
  }
}