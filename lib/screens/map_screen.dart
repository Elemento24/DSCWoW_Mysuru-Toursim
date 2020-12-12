import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../widgets/app_drawer.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> allMarkers = [];
  List<String> buttonText = ["Hospital", "Police", "Back"];
  GoogleMapController _controller;
  final latitude = 12.2958;
  var count = 0;
  final longitude = 76.6394;
  final latitudeMedicine = 12.296109;
  final longitudeMedicine = 76.643643;
  final latitudePolice = 12.296109;
  final longitudePolice = 76.646034;
  @override
  void initState() {
    super.initState();

    allMarkers.add(
      Marker(
          markerId: MarkerId('My Marker'),
          draggable: false,
          position: LatLng(latitude, longitude),
          onTap: () {
            print("Marker Tapped");
          }),
    );

    allMarkers.add(
      Marker(
          markerId: MarkerId('My Marker'),
          draggable: false,
          position: LatLng(latitudeMedicine, longitudeMedicine),
          onTap: () {
            print("Marker Tapped");
          }),
    );

    allMarkers.add(
      Marker(
          markerId: MarkerId('My Marker'),
          draggable: false,
          position: LatLng(latitudePolice, longitudePolice),
          onTap: () {
            print("Marker Tapped");
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(latitude, longitude), zoom: 15),
                  markers: Set.from(allMarkers),
                  onMapCreated: mapCreated,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (count == 0) {
                            moveToHospital();
                          } else if (count == 2) {
                            moveToHome();
                          } else {
                            moveToPoliceStation();
                          }
                          count = (count + 1) % 3;
                        });
                      },
                      child: Container(
                        height: 40.0,
                        width: 100.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber),
                        child: Text(
                          "${buttonText[count]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveToHospital() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latitudeMedicine, longitudeMedicine), zoom: 18)));
  }

  moveToHome() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15)));
  }

  moveToPoliceStation() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latitudePolice, longitudePolice), zoom: 18)));
  }
}
