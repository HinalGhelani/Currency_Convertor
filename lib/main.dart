import 'package:flutter/material.dart';
import 'package:sky_scrapper_1/Helper_class.dart';
import 'package:sky_scrapper_1/Modal_class.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyApp(),
      },
    ),
  );
}

class Global {
  static var country = ['USA', 'India', 'Canada', 'London'];
  static var country1 = ['India', 'USA', 'Canada', 'London'];
  static dynamic from = 'USA';
  static dynamic to = 'India';
  static dynamic amount = 0;
  static dynamic convertAmount = 0;
  static double cAmount1 = 0;
  static double cAmount2 = 0;
  static String sign = "";
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Currency Convertor",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: APIHelper.apiHelper.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR : ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              Currency? data = snapshot.data;
              return (data != null)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Currency \nConvertor",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "From",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                                iconSize: 35,
                                elevation: 16,
                                dropdownColor: const Color(0xffFBF9F9),
                                isExpanded: true,
                                alignment: Alignment.centerLeft,
                                borderRadius: BorderRadius.circular(10),
                                value: Global.from,
                                items: Global.country.map((e) {
                                  return DropdownMenuItem(
                                      value: e, child: Text(e));
                                }).toList(),
                                hint: const Text("Country"),
                                onChanged: (val) {
                                  setState(() {
                                    Global.from = val;
                                    if (Global.from == "India") {
                                      Global.cAmount2 =
                                          Global.amount * data.inr;
                                    } else if (Global.from == "USA") {
                                      Global.cAmount2 =
                                          Global.amount * data.usd;
                                    } else if (Global.from == "Canada") {
                                      Global.cAmount2 =
                                          Global.amount * data.cad;
                                    } else if (Global.from == "London") {
                                      Global.cAmount2 =
                                          Global.amount * data.gbp;
                                    }
                                  });
                                  print(Global.cAmount2);
                                  print(Global.from);
                                }),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "To",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                                // menuMaxHeight: 40,
                                iconSize: 35,
                                elevation: 16,
                                dropdownColor: const Color(0xffFBF9F9),
                                isExpanded: true,
                                alignment: Alignment.centerLeft,
                                borderRadius: BorderRadius.circular(10),
                                value: Global.to,
                                items: Global.country1.map((e) {
                                  return DropdownMenuItem(
                                      value: e, child: Text(e));
                                }).toList(),
                                hint: const Text("Country"),
                                onChanged: (val) {
                                  setState(() {
                                    Global.to = val;
                                    if (Global.to == "USA") {
                                      Global.cAmount1 = data.usd;
                                      print(Global.cAmount1);
                                      Global.sign = "\$";
                                    } else if (Global.to == "India") {
                                      Global.cAmount1 = data.inr;
                                      Global.sign = "\$";
                                    } else if (Global.to == "Canada") {
                                      Global.cAmount1 = data.cad;
                                      Global.sign = "\$";
                                    } else if (Global.to == "London") {
                                      Global.cAmount1 = data.gbp;
                                      Global.sign = "\$";
                                    }
                                  });
                                  print(Global.cAmount1);
                                  print(Global.to);
                                }),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                            ),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              onChanged: (val) {
                                Global.amount = int.parse(val);
                                print(Global.amount);
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Amount",
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                fillColor: Color(0xffFBF9F9),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Global.convertAmount =
                                      Global.cAmount2 * Global.cAmount1;
                                  print(Global.convertAmount);
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Convert",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Global.from,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(Icons.compare_arrows),
                              Text(
                                Global.to,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${Global.convertAmount}",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: Text("No data"),
                    );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
