import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'ads_managers.dart';
import 'package:firebase_admob/firebase_admob.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //initialized app id
  Admob.initialize(AdManager.appId);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admob Video Ad',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Admob Video Ad'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  AdmobReward reward;

  @override
  void initState() {
    super.initState();
    reward = AdmobReward(adUnitId: AdManager.rewardId);
    reward.load();
    reward = AdmobReward(
        adUnitId: AdManager.rewardId,
        listener: (event, args) {
          if (event == AdmobAdEvent.rewarded) {
            print("User rewarded after click");
          }
        });
    reward.load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admob list"),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          Container(height: 200,
          color: Colors.red,
          ),
            Expanded(

              child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    if (index % 5 == 0 && index != 0) {
                      return AdmobBanner(
                          adUnitId: AdManager.bannerId,
                          adSize: AdmobBannerSize.BANNER);
                    }
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  }
              ),
            ),
            // AdmobBanner(
            //     adUnitId: AdManager.bannerId, adSize: AdmobBannerSize.BANNER),
            // Row(
            //   children: <Widget>[
            //     RaisedButton(
            //       onPressed: () async {
            //         if (await interstitial.isLoaded) {
            //           interstitial.show();
            //         }
            //       },
            //       child: Text("Interstitial Ad"),
            //     ),



            RaisedButton(
              onPressed: () async {
                if (await reward.isLoaded) {
                  reward.show();
                }
              },
              child: Text("Reward Ad"),
            ),

          ],
        ),
      ),

    );
  }
}