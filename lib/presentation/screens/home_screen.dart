import 'package:flutter/material.dart';
import 'package:first_project/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> productList = [
    Product(
        name: 'Pullover',
        color: ' Black',
        size: ' L',
        price: 51,
        image: 'assets/images/blacktshirt1.png'),
    Product(
        name: 'T - Shirt',
        color: ' Gray',
        size: ' L',
        price: 30,
        image: 'assets/images/blacktshirt1.png'),
    Product(
        name: 'Sport Dress',
        color: ' Black',
        size: ' M',
        price: 43,
        image: 'assets/images/flutter1.png'),
  ];

  int totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check out'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Bag',
              style: TextStyle(
                fontSize: 33,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      Product product = productList[index];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: 120,
                                  width: 370,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        product.image,
                                        width: 120,
                                        height: 115,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  product.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                ),
                                                Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black38,
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Color : ',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  product.color,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                const Text(
                                                  'Size : ',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  product.size,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      Colors.black12,
                                                  child: IconButton(
                                                      onPressed: () =>
                                                          _onTapMinusButton(
                                                              index),
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        size: 18,
                                                      )),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  productList[index]
                                                      .quantity
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor:
                                                      Colors.black12,
                                                  child: IconButton(
                                                      onPressed: () =>
                                                          _onTapPlusButton(
                                                              index),
                                                      icon: const Icon(
                                                        Icons.add,
                                                        size: 18,
                                                      )),
                                                ),
                                                const SizedBox(
                                                  width: 50,
                                                ),
                                                Text(
                                                  '${productList[index].modeltotalPrice.toString()}\$',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    })),
            const SizedBox(
              height: 130,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Total amount: ',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(
                  width: 190,
                ),
                Text(
                  '${totalPrice}\$',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: SizedBox(
                width: 340,
                height: 50,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Your have suceesfully paid ${totalPrice}\$'),
                      ));
                    },
                    child: const Text(
                      'CHECK OUT',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )),
              ),
            )
          ],
        ));
  }

  void _onTapMinusButton(int index) {
    if (productList[index].quantity > 0) {
      setState(() {
        productList[index].quantity--;
        productList[index].modeltotalPrice =
            productList[index].quantity * productList[index].price;
        if (totalPrice >= 0) {
          totalPrice -= productList[index].price;
        }
      }); //totalPrice = pullOverTotalPrice + tShirtTotalPrice + sportTotalPrice;
    }
  }

  void _onTapPlusButton(int index) {
    setState(() {
      productList[index].quantity++;
      productList[index].modeltotalPrice =
          productList[index].quantity * productList[index].price;
      totalPrice += productList[index].price;
    });
  }
}
