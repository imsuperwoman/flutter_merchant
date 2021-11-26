import 'package:flutter/material.dart';
import 'package:mse_customer/screens/profile.dart';
import 'package:mse_customer/screens/request.dart';
import 'package:mse_customer/screens/wallet.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:mse_customer/util/custom_colors.dart';
import 'package:mse_customer/util/enum.dart';

import 'request_history.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBackground(""),
        body: Center(
          heightFactor: height / 4,
          child: homeBody(context), //New
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          selectedIconTheme:
              IconThemeData(color: CustomColor.primary, size: 35),
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold, color: CustomColor.primary),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "HISTORY",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'WALLET',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'PROFILE',
            ),
          ],
        ),
      )
    ]));
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RequestHistoryScreen()),
          );
          break;
        }
      case 2:
        {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WalletScreen()),
          );
          break;
        }
      case 3:
        {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        }
    }
  }
  //1 = IRON STEEL , 2 = CAN , 3= PAPER , 4 = GLASS, 5 = PLASTIC
  Widget homeBody(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    _onItemTapped(0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => RequestScreen(Materials.IRON_STEEL)),
            );
          },
          child: ClipRRect(
              child: Image.asset(
                "assets/images/S1-IRONSTEEL.gif",
                fit: BoxFit.fill,
                height: heightScreen / 7,
              ),
              borderRadius: BorderRadius.circular(20.0)),
        ),
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RequestScreen(Materials.CAN)),
          ),
          child: ClipRRect(
              child: Image.asset(
                "assets/images/S2-CANS.gif",
                fit: BoxFit.fill,
                height: heightScreen / 7,
              ),
              borderRadius: BorderRadius.circular(20.0)),
        ),
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RequestScreen(Materials.PAPER)),
          ),
          child: ClipRRect(
              child: Image.asset(
                "assets/images/S3-PAPER.gif",
                fit: BoxFit.fill,
                height: heightScreen / 7,
              ),
              borderRadius: BorderRadius.circular(20.0)),
        ),
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RequestScreen(Materials.GLASS)),
          ),
          child: ClipRRect(
              child: Image.asset(
                "assets/images/S4-GLASS.gif",
                fit: BoxFit.fill,
                height: heightScreen / 7,
              ),
              borderRadius: BorderRadius.circular(20.0)),
        ),
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RequestScreen(Materials.PLASTIC)),
          ),
          child: ClipRRect(
              child: Image.asset(
                "assets/images/S5-PLASTIC.gif",
                fit: BoxFit.fill,
                height: heightScreen / 7,
              ),
              borderRadius: BorderRadius.circular(20.0)),
        ),
      ]),
    );
  }
}
