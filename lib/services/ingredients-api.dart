import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what2bake/services/model.dart';
import 'package:what2bake/services/api.dart';

class IngredientsApi extends StatefulWidget {
  const IngredientsApi({super.key});

  @override
  State<IngredientsApi> createState() => _IngredientsApiState();
}

class _IngredientsApiState extends State<IngredientsApi> {

  List<String> pressed = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> update() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('0', pressed);
  }

  List<Product> products = [];
  Future<dynamic> future = getAllProducts();

  @override
  Widget build(BuildContext context) {
          var kontroler = ScrollController();
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF393838),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FutureBuilder<dynamic>(
                future: future,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData) {
                    products = snapshot.data[0];
                    pressed = snapshot.data[1];
                    return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                const CircleAvatar(),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Warzywa & owoce',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Lato',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${pressed.length}/${products.length} składników',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Lato',
                                          color: Color(0xFFB7B7B7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: const Color(0xFF232323),
                            height: 3,
                          ),
                          Expanded(
                            child: Scrollbar(
                              controller: kontroler,
                              interactive: true,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                controller: kontroler,
                                scrollDirection: Axis.vertical,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.start,
                                        alignment: WrapAlignment.start,
                                        spacing: 10,
                                        runSpacing: 0,
                                        children: [for (var i = 0; i < products.length; i++) TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: pressed.contains(products[i].id) ? const Color(0xFF607C08) : const Color(0xFF505050),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if(pressed.contains(products[i].id)) {
                                                  pressed.remove(products[i].id);
                                                } else {
                                                  pressed.add(products[i].id);
                                                }
                                                update();
                                              });
                                            },
                                            child: Text(
                                              products[i].name,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFD1D1D1),
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ),
                        ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            ),
          );

  }
}
