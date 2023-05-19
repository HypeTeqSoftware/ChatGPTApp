// import 'dart:async';
// import 'dart:io';
//
// import 'package:chatbot_app/screens/consumable_store.dart';
// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:intl/intl.dart';
//
// const String testID = 'android.test.purchased';
// const bool _kAutoConsume = true;
//
// const String threeMontsPlanID = 'android.test.purchased';
// const String halfYearPlan = 'android.test.purchased';
// const String yearlyPlan = 'android.test.purchased';
// //
// // class Purchase extends StatefulWidget {
// //   const Purchase({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Purchase> createState() => _PurchaseState();
// // }
// //
// // class _PurchaseState extends State<Purchase> {
// //   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
// //   bool _available = true;
// //   List<ProductDetails> _products = [];
// //   final List<PurchaseDetails> _purchases = [];
// //   StreamSubscription<List<PurchaseDetails>>? _subscription;
// //
// //   @override
// //   void initState() {
// //     final Stream<List<PurchaseDetails>> purchaseUpdated =
// //         _inAppPurchase.purchaseStream;
// //
// //     _subscription = purchaseUpdated.listen((purchaseDetailsList) {
// //       setState(() {
// //         _purchases.addAll(purchaseDetailsList);
// //         _listenToPurchaseUpdated(purchaseDetailsList);
// //       });
// //     }, onDone: () {
// //       _subscription!.cancel();
// //     }, onError: (error) {
// //       _subscription!.cancel();
// //     });
// //
// //     _initialize();
// //     super.initState();
// //   }
// //
// //   @override
// //   void dispose() {
// //     // cancelling the subscription
// //     _subscription!.cancel();
// //
// //     super.dispose();
// //   }
// //
// //   void _initialize() async{
// //     _available = await _inAppPurchase.isAvailable();
// //
// //     List<ProductDetails> products = await _getProducts(productId: Set<String>.from([testID]));
// //
// //     setState(() {
// //       _products = products;
// //     });
// //   }
// //
// //   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList){
// //     purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async{
// //       switch (purchaseDetails.status){
// //         case PurchaseStatus.pending:
// //           // _showPendingUI();
// //           break;
// //         case PurchaseStatus.purchased:
// //         case PurchaseStatus.restored:
// //           //bool valid = await _verifyPurchase(purchaseDetails);
// //           // if(!valid){
// //           //   _handleInvalidPurchase(purchaseDetails);
// //           // }
// //           break;
// //         case PurchaseStatus.error:
// //           print(purchaseDetails.error);
// //           //_handleError(purchaseDetails.error);
// //           break;
// //         default:
// //           break;
// //       }
// //
// //       if(purchaseDetails.pendingCompletePurchase){
// //         await _inAppPurchase.completePurchase(purchaseDetails);
// //       }
// //     });
// //   }
// //
// //   Future<List<ProductDetails>> _getProducts({required Set<String> productId})async{
// //     ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(productId);
// //     return response.productDetails;
// //   }
// //
// //   ListTile _buildProduct({required ProductDetails product}){
// //     return ListTile(
// //       leading: const Icon(Icons.attach_money),
// //       title:  Text('${product.title} - ${product.price}'),
// //       subtitle: Text(product.description.toString()),
// //       trailing: ElevatedButton(
// //         onPressed: () => _subscribe(product: product), child: const Text('Subscribe'),
// //       ),
// //     );
// //   }
// //
// //   ListTile _buildPurchase({required PurchaseDetails purchase}) {
// //     if(purchase.error != null){
// //       return ListTile(
// //         title:  Text('${purchase.error}'),
// //         subtitle: Text(purchase.status.toString()),
// //       );
// //     }
// //
// //     String? transactionDate;
// //     if(purchase.status == PurchaseStatus.purchased){
// //       DateTime date = DateTime.fromMicrosecondsSinceEpoch(int.parse(purchase.transactionDate!),);
// //       transactionDate = ' @ ${DateFormat('yyyy-MM-dd HH:mm:ss').format(date)}';
// //     }
// //
// //     return ListTile(
// //       title:  Text('${purchase.productID} ${transactionDate ?? ''}'),
// //       subtitle: Text(purchase.status.toString()),
// //     );
// //   }
// //
// //   void _subscribe({required ProductDetails product}){
// //     final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
// //     _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title:
// //             Text(_available ? 'Product Available' : 'No Product Available'),
// //       ),
// //       body: _available
// //       ? Column(
// //         children: [
// //           Expanded(child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //              Text("Current Products ${_products.length}"),
// //               ListView.builder(
// //                 shrinkWrap: true,
// //                   itemCount: _products.length,
// //                   itemBuilder: (context, index){return _buildProduct(product: _products[index]);})
// //           ],)),
// //           Expanded(child: Column(children: [
// //             Text("Past Purchases: ${_products.length}"),
// //             ListView.builder(
// //                 shrinkWrap: true,
// //                 itemCount: _purchases.length,
// //                 itemBuilder: (context, index){return _buildPurchase(purchase:  _purchases[index]);})
// //           ],))
// //         ],
// //       ) : const  Center(child:  Text('This is not available'),),
// //     );
// //   }
// // }
// const List<String> _kProductIds = <String>[
//   threeMontsPlanID,
//   halfYearPlan,
//   yearlyPlan
// ];
//
// class Purchase extends StatefulWidget {
//   const Purchase({Key? key}) : super(key: key);
//
//   @override
//   State<Purchase> createState() => _PurchaseState();
// }
//
// class _PurchaseState extends State<Purchase> {
//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//   List<String> _notFoundIds = [];
//   List<ProductDetails> _products = [];
//   List<PurchaseDetails> _purchases = [];
//   List<String> _consumables = [];
//   bool _isAvailable = false;
//   bool _purchasePending = false;
//   bool _loading = true;
//   String? _queryProductError;
//   @override
//   void initState() {
//     final Stream<List<PurchaseDetails>> purchaseUpdated =
//         _inAppPurchase.purchaseStream;
//     _subscription = purchaseUpdated.listen((purchaseDetailsList) {
//       _listenToPurchaseUpdated(purchaseDetailsList);
//     }, onDone: () {
//       _subscription.cancel();
//     }, onError: (error) {
//       _subscription.resume();
//     });
//     initStoreInfo();
//     super.initState();
//   }
//
//   Future<void> initStoreInfo() async {
//     final bool isAvailable = await _inAppPurchase.isAvailable();
//     if (!isAvailable) {
//       setState(() {
//         _isAvailable = isAvailable;
//         _products = [];
//         _purchases = [];
//         _notFoundIds = [];
//         _consumables = [];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     if (Platform.isIOS) {
//       var iosPlatformAddition = _inAppPurchase
//           .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
//     }
//
//     ProductDetailsResponse productDetailResponse =
//     await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
//     if (productDetailResponse.error != null) {
//       setState(() {
//         _queryProductError = productDetailResponse.error!.message;
//         _isAvailable = isAvailable;
//         _products = productDetailResponse.productDetails;
//         _purchases = [];
//         _notFoundIds = productDetailResponse.notFoundIDs;
//         _consumables = [];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     if (productDetailResponse.productDetails.isEmpty) {
//       setState(() {
//         _queryProductError = null;
//         _isAvailable = isAvailable;
//         _products = productDetailResponse.productDetails;
//         _purchases = [];
//         _notFoundIds = productDetailResponse.notFoundIDs;
//         _consumables = [];
//         _purchasePending = false;
//         _loading = false;
//       });
//       return;
//     }
//
//     List<String> consumables = await ConsumableStore.load();
//     setState(() {
//       _isAvailable = isAvailable;
//       _products = productDetailResponse.productDetails;
//       _notFoundIds = productDetailResponse.notFoundIDs;
//       _consumables = consumables;
//       _purchasePending = false;
//       _loading = false;
//     });
//   }
//
//   @override
//   void dispose() {
//     if (Platform.isIOS) {
//       var iosPlatformAddition = _inAppPurchase
//           .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       iosPlatformAddition.setDelegate(null);
//     }
//     _subscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> stack = [];
//     if (_queryProductError == null) {
//       stack.add(
//         ListView(
//           children: [
//             _buildConnectionCheckTile(),
//             _buildProductList(),
//             _buildConsumableBox(),
//             // _buildRestoreButton(),
//           ],
//         ),
//       );
//     } else {
//       stack.add(Center(
//         child: Text(_queryProductError!),
//       ));
//     }
//     if (_purchasePending) {
//       stack.add(
//         Stack(
//           children: const [
//             Opacity(
//               opacity: 0.3,
//               child: ModalBarrier(dismissible: false, color: Colors.grey),
//             ),
//             Center(
//               child: CircularProgressIndicator(),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('IAP Example'),
//         ),
//         body: Stack(
//           children: stack,
//         ),
//       ),
//     );
//   }
//
//   Card _buildConnectionCheckTile() {
//     if (_loading) {
//       return const Card(child: ListTile(title: Text('Trying to connect...')));
//     }
//     final Widget storeHeader = ListTile(
//       leading: Icon(_isAvailable ? Icons.check : Icons.block,
//           color: _isAvailable ? Colors.green : ThemeData.light().errorColor),
//       title: Text(
//           'The store is ' + (_isAvailable ? 'available' : 'unavailable') + '.'),
//     );
//     final List<Widget> children = <Widget>[storeHeader];
//
//     if (!_isAvailable) {
//       children.addAll([
//         const Divider(),
//         ListTile(
//           title: Text('Not connected',
//               style: TextStyle(color: ThemeData.light().errorColor)),
//           subtitle: const Text(
//               'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
//         ),
//       ]);
//     }
//     return Card(child: Column(children: children));
//   }
//
//   Card _buildProductList() {
//     if (_loading) {
//       return const Card(
//           child: (ListTile(
//               leading: CircularProgressIndicator(),
//               title: Text('Fetching products...'))));
//     }
//     if (!_isAvailable) {
//       return const Card();
//     }
//     const ListTile productHeader = ListTile(title: Text('Products for Sale'));
//     List<ListTile> productList = <ListTile>[];
//     if (_notFoundIds.isNotEmpty) {
//       productList.add(ListTile(
//           title: Text('[${_notFoundIds.join(", ")}] not found',
//               style: TextStyle(color: ThemeData.light().errorColor)),
//           subtitle: const Text(
//               'This app needs special configuration to run. Please see example/README.md for instructions.')));
//     }
//
//     // This loading previous purchases code is just a demo. Please do not use this as it is.
//     // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
//     // We recommend that you use your own server to verify the purchase data.
//     Map<String, PurchaseDetails> purchases =
//     Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
//       if (purchase.pendingCompletePurchase) {
//         _inAppPurchase.completePurchase(purchase);
//       }
//       return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
//     }));
//     productList.addAll(_products.map(
//           (ProductDetails productDetails) {
//         PurchaseDetails? previousPurchase = purchases[productDetails.id];
//         return ListTile(
//             title: Text(
//               productDetails.title,
//             ),
//             subtitle: Text(
//               productDetails.description,
//             ),
//             trailing: previousPurchase != null
//                 ? IconButton(
//                 onPressed: () => confirmPriceChange(context),
//                 icon: const Icon(Icons.upgrade))
//                 : TextButton(
//               child: Text(productDetails.price),
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.green[800],
//                 primary: Colors.white,
//               ),
//               onPressed: () {
//                 late PurchaseParam purchaseParam;
//
//                 if (Platform.isAndroid) {
//                   // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
//                   // verify the latest status of you your subscription by using server side receipt validation
//                   // and update the UI accordingly. The subscription purchase status shown
//                   // inside the app may not be accurate.
//                   final oldSubscription =
//                   _getOldSubscription(productDetails, purchases);
//
//                   purchaseParam = GooglePlayPurchaseParam(
//                       productDetails: productDetails,
//                       applicationUserName: null,
//                       changeSubscriptionParam: (oldSubscription != null)
//                           ? ChangeSubscriptionParam(
//                         oldPurchaseDetails: oldSubscription,
//                         prorationMode: ProrationMode
//                             .immediateWithTimeProration,
//                       )
//                           : null);
//                 } else {
//                   purchaseParam = PurchaseParam(
//                     productDetails: productDetails,
//                     applicationUserName: null,
//                   );
//                 }
//
//                 if ((productDetails.id == threeMontsPlanID) || (productDetails.id == halfYearPlan) ||
//                     (productDetails.id == yearlyPlan)) {
//                   _inAppPurchase.buyConsumable(
//                       purchaseParam: purchaseParam,
//                       autoConsume: _kAutoConsume || Platform.isIOS);
//                 } else {
//                   _inAppPurchase.buyNonConsumable(
//                       purchaseParam: purchaseParam);
//                 }
//               },
//             ));
//       },
//     ));
//
//     return Card(
//         child: Column(
//             children: <Widget>[productHeader, const Divider()] + productList));
//   }
//
//   Card _buildConsumableBox() {
//     if (_loading) {
//       return const Card(
//           child: (ListTile(
//               leading: CircularProgressIndicator(),
//               title: Text('Fetching consumables...'))));
//     }
//     if (!_isAvailable || _notFoundIds.contains(threeMontsPlanID)) {
//       return const Card();
//     }
//     const ListTile consumableHeader =
//     ListTile(title: Text('Purchased consumables'));
//     final List<Widget> tokens = _consumables.map((String id) {
//       return GridTile(
//         child: IconButton(
//           icon: const Icon(
//             Icons.stars,
//             size: 42.0,
//             color: Colors.orange,
//           ),
//           splashColor: Colors.yellowAccent,
//           onPressed: () => consume(id),
//         ),
//       );
//     }).toList();
//     return Card(
//         child: Column(children: <Widget>[
//           consumableHeader,
//           const Divider(),
//           GridView.count(
//             crossAxisCount: 5,
//             children: tokens,
//             shrinkWrap: true,
//             padding: const EdgeInsets.all(16.0),
//           )
//         ]));
//   }
//
//   Widget _buildRestoreButton() {
//     if (_loading) {
//       return Container();
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           TextButton(
//             child: const Text('Restore purchases'),
//             style: TextButton.styleFrom(
//               backgroundColor: Theme.of(context).primaryColor,
//               primary: Colors.white,
//             ),
//             onPressed: () => _inAppPurchase.restorePurchases(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> consume(String id) async {
//     await ConsumableStore.consume(id);
//     final List<String> consumables = await ConsumableStore.load();
//     setState(() {
//       _consumables = consumables;
//     });
//   }
//
//   void showPendingUI() {
//     setState(() {
//       _purchasePending = true;
//     });
//   }
//
//   void deliverProduct(PurchaseDetails purchaseDetails) async {
//     // IMPORTANT!! Always verify purchase details before delivering the product.
//     if ((purchaseDetails.productID == threeMontsPlanID) ||
//         (purchaseDetails.productID == halfYearPlan) ||
//         (purchaseDetails.productID == yearlyPlan)) {
//       await ConsumableStore.save(purchaseDetails.purchaseID!);
//       List<String> consumables = await ConsumableStore.load();
//       setState(() {
//         _purchasePending = false;
//         _consumables = consumables;
//       });
//     } else {
//       setState(() {
//         _purchases.add(purchaseDetails);
//         _purchasePending = false;
//       });
//     }
//   }
//
//   void handleError(IAPError error) {
//     setState(() {
//       _purchasePending = false;
//     });
//   }
//
//   Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
//     // IMPORTANT!! Always verify a purchase before delivering the product.
//     // For the purpose of an example, we directly return true.
//     return Future<bool>.value(true);
//   }
//
//   void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
//     // handle invalid purchase here if  _verifyPurchase` failed.
//   }
//
//   void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
//     purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         showPendingUI();
//       } else {
//         if (purchaseDetails.status == PurchaseStatus.error) {
//           handleError(purchaseDetails.error!);
//         } else if (purchaseDetails.status == PurchaseStatus.purchased ||
//             purchaseDetails.status == PurchaseStatus.restored) {
//           bool valid = await _verifyPurchase(purchaseDetails);
//           if (valid) {
//             deliverProduct(purchaseDetails);
//           } else {
//             _handleInvalidPurchase(purchaseDetails);
//             return;
//           }
//         }
//         if (purchaseDetails.pendingCompletePurchase) {
//           await _inAppPurchase.completePurchase(purchaseDetails);
//         }
//       }
//     });
//   }
//
//   Future<void> confirmPriceChange(BuildContext context) async {
//     if (Platform.isAndroid) {
//       final InAppPurchaseAndroidPlatformAddition androidAddition =
//       _inAppPurchase
//           .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
//       var priceChangeConfirmationResult =
//       await androidAddition.launchPriceChangeConfirmationFlow(
//         sku: 'purchaseId',
//       );
//       if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Price change accepted'),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             priceChangeConfirmationResult.debugMessage ??
//                 "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
//           ),
//         ));
//       }
//     }
//     if (Platform.isIOS) {
//       var iapStoreKitPlatformAddition = _inAppPurchase
//           .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
//     }
//   }
//
//   GooglePlayPurchaseDetails? _getOldSubscription(
//       ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
//     // This is just to demonstrate a subscription upgrade or downgrade.
//     // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
//     // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
//     // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
//     // Please remember to replace the logic of finding the old subscription Id as per your app.
//     // The old subscription is only required on Android since Apple handles this internally
//     // by using the subscription group feature in iTunesConnect.
//     GooglePlayPurchaseDetails? oldSubscription;
//     // if (productDetails.id == basePlan180 &&
//     //     purchases[_kGoldSubscriptionId] != null) {
//     //   oldSubscription =
//     //       purchases[_kGoldSubscriptionId] as GooglePlayPurchaseDetails;
//     // } else if (productDetails.id == _kGoldSubscriptionId &&
//     //     purchases[basePlan180] != null) {
//     //   oldSubscription = purchases[basePlan180] as GooglePlayPurchaseDetails;
//     // }
//     return oldSubscription;
//   }
// }
//
// /// Example implementation of the
// /// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
// ///
// /// The payment queue delegate can be implementated to provide information
// /// needed to complete transactions.
// class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
//   @override
//   bool shouldContinueTransaction(
//       SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
//     return true;
//   }
//
//   @override
//   bool shouldShowPriceConsent() {
//     return false;
//   }
// }
