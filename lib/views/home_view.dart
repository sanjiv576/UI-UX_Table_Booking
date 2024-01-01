import 'package:flutter/material.dart';

import '../services/networking.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  var _products;

  late double width;
  late double height;

  @override
  void initState() {
    super.initState();

    getProductData();
  }

  void getProductData() async {
    OnlineStore onlineStore = OnlineStore();

    var products = await onlineStore.getData();

    if (products != null) {
      for (int i = 0; i < products.length; i++) {
        print('id: ${products[i].id}');
        print('Product ${i + 1}: ${products[i]}');
        print('---------------');
      }

      _products = products;
    }
  }

  final _verticalGap = const SizedBox(height: 30);
  final _horizontalGap = const SizedBox(width: 20);

  @override
  Widget build(BuildContext context) {
    // get sizes of the device, then, send to device size class
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print('Width: $width');
    print('Height: $height');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            // padding: const EdgeInsets.all(12.0),
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.05, vertical: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi User',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                _horizontalGap,
                const Card(
                  color: Colors.black,
                  child: ListTile(),
                ),
                _verticalGap,
                const Text('Product categories'),
                _verticalGap,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 10; i++) ...{
                        Container(
                          height: 100,
                          width: 100,
                          color: Colors.black,
                        ),
                        _horizontalGap,
                      }
                    ],
                  ),
                ),
                _verticalGap,
                const Text('All Products'),
                _verticalGap,
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0; i < 10; i++) ...{
                        Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.red,
                        ),
                        _verticalGap
                      }
                    ],
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
