import 'package:flutter/material.dart';
import 'package:test_flutter/models/Product.dart';
import 'package:test_flutter/products_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    List<Product> productList = ProductsList().productList;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(0xffbcb7b7),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.notifications),
            ),
            Padding(
              child: Icon(Icons.chat),
              padding: EdgeInsets.symmetric(horizontal: 16),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/clarity_dashboard.png'),
                label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/carbon_growth.png'),
                label: 'Investments'),
          ],
        ),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const HeaderWidget(),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'What are you looking for?',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                showProductList(productList),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffe5e5e5)),
                      ),
                      Positioned(
                        left: getActualScrollPosition(productList),
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff3f7d9d)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SaveTaxWidget(),
                // Text(MediaQuery.of(context).orientation.name),
                const SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 20),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Start',
                                style: TextStyle(
                                  color: Color(0xff008f65),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'One-Time',
                                style: TextStyle(
                                    color: Color(0xff008f65),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          width: 100,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: Color.fromRGBO(
                                42, 208, 167, 0.5600000023841858),
                          )),
                      Container(
                          margin: EdgeInsets.only(right: 20),
                          padding: EdgeInsets.all(10),
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Start',
                                style: TextStyle(
                                  color: Color(0xff008f65),
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'SIP',
                                style: TextStyle(
                                    color: Color(0xff008f65),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: Color.fromRGBO(
                                98, 225, 164, 0.7300000190734863),
                          )),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 4),
                                blurRadius: 4)
                          ],
                          color: Color.fromRGBO(88, 169, 204, 1),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start',
                              style: TextStyle(
                                color: Color(0xff00567b),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Dynamic SIP',
                              style: TextStyle(
                                  color: Color(0xff00567b),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
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

  double getActualScrollPosition(List<Product> productList) {
    return scrollPosition / (100 / 50);
  }

  SizedBox showProductList(List<Product> productList) {
    return SizedBox(
      height: 150,
      child: NotificationListener<ScrollNotification>(
        child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (ctx, index) {
            return ProductItemWidget(product: productList[index]);
          },
          scrollDirection: Axis.horizontal,
        ),
        onNotification: (scrollNotification) {
          print(scrollNotification.metrics.pixels);
          print(scrollNotification.metrics.maxScrollExtent);
          setState(() {
            scrollPosition = scrollNotification.metrics.pixels /
                scrollNotification.metrics.maxScrollExtent *
                100;
          });
          return false;
        },
      ),
    );
  }
}

class SaveTaxWidget extends StatelessWidget {
  const SaveTaxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfffbfbfb),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'You can save tax',
                style: TextStyle(
                    color: Color(0xff008f65),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'upto 150000/-',
                style: TextStyle(
                    color: Color(0xff008f65),
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('SAVE TAX NOW'),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 30),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    elevation: MaterialStateProperty.all(0),
                    foregroundColor: MaterialStateProperty.all(
                      const Color(0xff008f65),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
              ),
            ],
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(79, 201, 98, 0.6299999952316284),
                  Color.fromRGBO(5, 189, 144, 1)
                ]),
          )),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/${product.iconName}'),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
          ),
          const SizedBox(
            height: 5,
          ),
          Flexible(
            child: Text(
              product.name,
              style: const TextStyle(color: Color(0xffbcb7b7), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xffeeeeee)),
                  child: Image.asset('assets/trending_up.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'You have',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: const [
                        Text(
                          '26% increase',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                        Text(
                          ' in your portfolio',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'View More',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 18,
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                colors: [Color(0xff1F4C82), Color(0xff3F7D9D)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)));
  }
}
