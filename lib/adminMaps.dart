import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/placeholder.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(28.69936867761485, 77.19193658580859),
        icon: mapMarker,
        infoWindow: InfoWindow(
          title: 'Pentamed Hospital',
          snippet: 'Hospital',
        ),
      ));
    });

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(28.698881881299997, 77.18698565330817),
        icon: mapMarker,
        infoWindow: InfoWindow(
          title: 'Vinayak Hospital',
          snippet: 'Hospital',
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(
              target: LatLng(28.69936867761485, 77.19193658580859), zoom: 15)),
    );
  }
}
