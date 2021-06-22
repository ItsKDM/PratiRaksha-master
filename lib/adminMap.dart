// import 'package:flutter/material.dart';
// import 'package:map_view/map_view.dart';

// var api_key = "AIzaSyC4dTBTGG_5cn0fKK2dSV8DTiuFN63y7Aw";

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   MapView mapView = new MapView();
//   CameraPosition cameraPosition;
//   var staticMapProvider = new StaticMapProvider(api_key);
//   Uri staticMapUri;

//   List<Marker> markers = <Marker>[
//     new Marker("1", "Pentamed Hospital", 28.69936867761485, 77.19193658580859,
//         color: Colors.amber),
//     new Marker("2", "Vinayak Hospital", 28.698881881299997, 77.18698565330817,
//         color: Colors.purple),
//   ];

//   showMap() {
//     mapView.show(new MapOptions(
//         mapViewType: MapViewType.normal,
//         initialCameraPosition:
//             new CameraPosition(new Location(28.420035, 77.337628), 15.0),
//         showUserLocation: true,
//         title: "Recent Location"));
//     mapView.setMarkers(markers);
//     mapView.zoomToFit(padding: 100);

//     mapView.onMapTapped.listen((_) {
//       setState(() {
//         mapView.setMarkers(markers);
//         mapView.zoomToFit(padding: 100);
//       });
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     cameraPosition =
//         new CameraPosition(new Location(28.420035, 77.337628), 2.0);
//     staticMapUri = staticMapProvider.getStaticUri(
//         new Location(28.420035, 77.337628), 12,
//         height: 400, width: 900, mapType: StaticMapViewType.roadmap);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Google maps"),
//       ),
//       body: new Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           new Container(
//             height: 300.0,
//             child: new Stack(
//               children: <Widget>[
//                 new Center(
//                   child: Container(
//                     child: new Text(
//                       "Map should show here",
//                       textAlign: TextAlign.center,
//                     ),
//                     padding: const EdgeInsets.all(20.0),
//                   ),
//                 ),
//                 new InkWell(
//                   child: new Center(
//                     child: new Image.network(staticMapUri.toString()),
//                   ),
//                   onTap: showMap,
//                 )
//               ],
//             ),
//           ),
//           new Container(
//             padding: new EdgeInsets.only(top: 10.0),
//             child: new Text(
//               "Tap the map to interact",
//               style: new TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           new Container(
//             padding: new EdgeInsets.only(top: 25.0),
//             child: new Text(
//                 "Camera Position: \n\nLat: ${cameraPosition.center.latitude}\n\nLng:${cameraPosition.center.longitude}\n\nZoom: ${cameraPosition.zoom}"),
//           ),
//         ],
//       ),
//     );
//   }
// }
