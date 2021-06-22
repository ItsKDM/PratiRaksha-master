// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:meal_monkey_partner/Config/config.dart';
// import 'package:meal_monkey_partner/Widgets/ui_helper.dart';
// import 'package:meal_monkey_partner/models/item.dart';

// import '../adminOrderDetails.dart';

// int counter = 0;

// class OrderCard extends StatelessWidget {
//   final int itemCount;
//   final List<DocumentSnapshot> data;
//   final String orderID;

//   OrderCard({Key key, this.data, this.itemCount, this.orderID})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Route route;
//         if (counter == 0) {
//           counter = counter + 1;
//           route = MaterialPageRoute(
//               builder: (c) => AdminOrderDetails(orderID: orderID));
//         }
//         Navigator.push(context, route);
//       },
//       child: Container(
//         padding: EdgeInsets.all(10.0),
//         margin: EdgeInsets.all(10.0),
//         height: itemCount * 190.0,
//         child: ListView.builder(
//           itemCount: itemCount,
//           physics: NeverScrollableScrollPhysics(),
//           itemBuilder: (c, index) {
//             ItemModel model = ItemModel.fromJson(data[index].data());
//             return sourceOrderInfo(model, context);
//           },
//         ),
//       ),
//     );
//   }
// }

// Widget sourceOrderInfo(ItemModel model, BuildContext context,
//     {Color background}) {
//   return Container(
//     color: Colors.grey[100],
//     height: 170.0,
//     width: MediaQuery.of(context).size.width,
//     child: Row(
//       children: <Widget>[
//         Image.network(
//           model.thumbnailUrl,
//           width: 180.0,
//         ),
//         SizedBox(width: 10.0),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(height: 15.0),
//               Container(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         model.title,
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 5.0),
//               Container(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         model.shortInfo,
//                         style: TextStyle(
//                             color: Colors.black.withOpacity(0.7),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Row(
//                 children: <Widget>[
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(top: 0.0),
//                         child: Row(
//                           children: [
//                             Text(
//                               "Total Amount",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green),
//                             ),
//                             Text(
//                               (model.price).toString(),
//                               style: TextStyle(
//                                   color: Colors.black.withOpacity(0.8),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               Flexible(
//                 child: Container(),
//               ),
//               Divider(
//                 height: 5.0,
//                 color: Colors.pink,
//               )
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }

// // Widget sourceInfo(ItemModel model, BuildContext context,
// //     {Color background, removeCartFunction}) {
// //   return InkWell(
// //     onTap: () {},
// //     child: ListTile(
// //       leading: ClipOval(
// //         child: Image.network(
// //           model.thumbnailUrl,
// //           height: 50.0,
// //           fit: BoxFit.cover,
// //           width: 50.0,
// //         ),
// //       ),
// //       title: Text(model.title.toString()),
// //       subtitle: Column(
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         crossAxisAlignment: CrossAxisAlignment.stretch,
// //         children: [
// //           UIHelper.verticalSpaceExtraSmall(),
// //           Text(model.shortInfo.toString()),
// //           UIHelper.verticalSpaceExtraSmall(),
// //           Text("Rs " + model.price.toString()),
// //         ],
// //       ),
// //       trailing: Container(
// //         child: removeCartFunction == null
// //             ? IconButton(
// //                 icon: Icon(
// //                   Icons.add,
// //                   color: Colors.black.withOpacity(0.7),
// //                 ),
// //                 onPressed: () {
// //                   checkItemInCart(model.shortInfo, context);
// //                 },
// //               )
// //             : IconButton(
// //                 icon: Icon(Icons.delete, color: Colors.red),
// //                 onPressed: () {
// //                   removeCartFunction();
// //                   Navigator.of(context).push(
// //                       MaterialPageRoute(builder: (context) => StoreHome()));
// //                 },
// //               ),
// //       ),
// //     ),
// //   );
// // }
