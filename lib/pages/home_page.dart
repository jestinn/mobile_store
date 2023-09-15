import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '/pages/product_details_page.dart';

import '../models/product_model.dart';
import '../widgets/search_delegate_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  ProductModel productModel = ProductModel();
  Product? source;
  final dio = Dio();

  void getData() async {
    Response response;
    response = await dio.get('https://dummyjson.com/products');
    debugPrint(response.data.toString());
    productModel = ProductModel.fromJson(response.data);
    setState(() {
      isLoading = false;
    });
    debugPrint("productModel.products");
    // print(productModel.products!.first.title);
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black.withOpacity(.7),
      appBar: AppBar(
        title: const Text(
          "MyStore",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    child: const SearchBarWidget(),
                    onTap: () => showSearchDelegateSource(context),
                  ),
                  Flexible(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            productModel.products![index].thumbnail ??
                                "https://images.unsplash.com/photo-1489389944381-3471b5b30f04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
                          ),
                        ),
                        title: Text(
                          productModel.products![index].title ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          productModel.products![index].description ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                                product: productModel.products![index]),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: productModel.products!.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> showSearchDelegateSource(
    BuildContext context,
  ) async {
    var result = await showSearch(
      context: context,
      delegate: SearchDelegateWidget(
        suggestions1: productModel.products!,
      ),
    );
    if (result != null) {
      setState(() {
        source = result;
      });
    }
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        top: 23,
        bottom: 14,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.transparent, width: 1)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 10),
          Text(
            "Search Product",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
