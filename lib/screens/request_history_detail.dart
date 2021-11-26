import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mse_customer/models/request_history_detail.dart';
import 'package:mse_customer/screens/widgets/decoration.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestHistoryDetailScreen extends StatefulWidget {
  @override
  _RequestHistoryDetailScreenState createState() => _RequestHistoryDetailScreenState();
}

class _RequestHistoryDetailScreenState extends State<RequestHistoryDetailScreen> {

  List<XFile> _imageFileList = [];
  late HistoryDetail request ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
          appBar: appBarColor("MATEL" ),
          backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  enabled: false,
                  decoration: buildInputDecoration("Cheras"),
                ),
                TextField(
                  enabled: false,
                  decoration: buildInputDecoration("101.27481,13.198"),
                ),
                TextField(
                  enabled: false,
                  decoration: buildInputDecoration("Total = 20kg"),
                ),
                TextField(
                  enabled: false,
                  decoration: buildInputDecoration("Remarks"),
                ),
                SizedBox( height: 10.0),
                label18BoldText("images".tr()),
                SizedBox(height: 10.0),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1,crossAxisSpacing: 10
                  ),
                  shrinkWrap: true,
                  children: [
                    Image.network('https://picsum.photos/250?image=1'),
                    Image.network('https://picsum.photos/250?image=2'),
                    Image.network('https://picsum.photos/250?image=3'),
                  ],
                ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                child: ClipRRect(
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    markers: {Marker(
                  markerId: const MarkerId('origin'),
                  infoWindow: const InfoWindow(title: 'Origin'),
                  icon:
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  position: LatLng(3.1023779492577472, 101.72618172416381),
                  )},
                    initialCameraPosition: CameraPosition(
                      target: LatLng(3.1023779492577472, 101.72618172416381),zoom: 10
                    ),
                  ),
                ),
              ),
                SizedBox( height: 20.0),
                CircleAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                    radius: 70.0,
                    child: CircleAvatar(
                        radius: 65.0,
                        backgroundColor: Colors.white,
                        backgroundImage: profileImages().image),
                  ),
                SizedBox( height: 20.0),
                Center(child: label18Text("Lim")),
                Center(child: label18Text("WWW 1234")),
                Center(child: label18Text("B 182673012")),
                Center(child: label18Text("751208-14-1234")),
                SizedBox( height: 10.0),
                Divider(color: Colors.white, thickness: 2),
                SizedBox( height: 10.0),
                Center(child: label18BoldText("Result")),
                SizedBox( height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child:  label18Text("Weight")
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child:  Center(child: labelBigRightText(":"))
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child:  label18Text("100kg")
                      ),
                    ),
                  ],
                ),
                SizedBox( height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                          child:  label18Text("Selling Price")
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                          child:  Center(child: labelBigRightText(":"))
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                          child:  label18Text("RM365")
                      ),
                    ),
                  ],
                ),
                SizedBox( height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child:  label18Text("Buying Rate")
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child:  Center(child: labelBigRightText(":"))
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child:  RichText(
                            text: TextSpan(
                              text: 'RM300 \n',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white ),
                              children: <TextSpan>[
                                TextSpan(text: 'Month - May 2021',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white )),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox( height: 20.0),
                Divider(color: Colors.white, thickness: 2),
                SizedBox( height: 20.0),
                Center(child: label18BoldText("Scaling Result Images")),
                SizedBox( height: 20.0),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1,crossAxisSpacing: 10
                  ),
                  shrinkWrap: true,
                  children: [
                    Image.network('https://picsum.photos/250?image=1'),
                    Image.network('https://picsum.photos/250?image=2'),
                    Image.network('https://picsum.photos/250?image=3'),
                  ],
                ),
                SizedBox(height: 20.0),
                Center(child: label18BoldText("CCTV")),
                SizedBox(height: 20.0),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1,crossAxisSpacing: 10
                  ),
                  shrinkWrap: true,
                  children: List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 5),
                          image: DecorationImage(
                            image: NetworkImage('https://picsum.photos/250?image=2'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0),),
                        ),
                      ),
                    );
                  },),
                ),
              ],
            ),
          ),
        )),
    ]));
  }

  Widget buildGridView() {
    return GridView.count(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(_imageFileList.length, (index) {
        print("================" + _imageFileList.length.toString());
        if (_imageFileList[index] is XFile) {
          print(index);
          print(_imageFileList[index].path);
          return Padding(
            padding: const EdgeInsets.all(spaceTiny),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                CircleAvatar(
                    radius: 70.0,
                    backgroundColor: Colors.white,
                    backgroundImage: profileImages().image),
                Container(
                    child: IconButton(
                      icon: Icon(Icons.delete_forever),
                      iconSize: 20,
                      color: Colors.red,
                      onPressed: () {
                        if (_imageFileList[index] != null) {
                          setState(() {
                            _imageFileList.removeAt(index);
                          });
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(5.0, 5.0))
                      ],
                    )),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 10.0,
          );
        }
      }),
    );
  }
}
