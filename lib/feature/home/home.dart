import 'package:flutter/material.dart';
import 'list_item.dart';
import 'model.dart';
import 'api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

const int limit = 20;
int page = 1;

class _HomeState extends State<Home> {
  final ScrollController sc = ScrollController();
  List<ProductModel> products = [];

  bool isLoading = false;
  bool isRefreshing = false;
  bool isMoreFetching = false;
  bool isFetching = false;
  bool isError = false;
  bool hasMoreData = true;
  bool hasData = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    sc.addListener(() {
      if (sc.position.pixels >= sc.position.maxScrollExtent) {
        fetchMoreData();
      }
    });
  }

  Future<void> refresh() async {
    setState(() => isRefreshing = true);
    await fetchData();
    setState(() => isRefreshing = false);
  }

  Future<void> fetchData() async {
    if (isFetching) return;

    setState(() {
      isLoading = true;
      isError = false;
      hasData = true;
      isFetching = true;
      hasMoreData = true;
      products.clear();
    });

    page = 1;
    final List<ProductModel>? res = await Api.getPost(page, limit);

    if (res == null) {
      setState(() {
        isError = true;
        isFetching = false;
        isLoading = false;
      });
      return;
    }

    if (res.isEmpty) {
      setState(() {
        hasData = false;
        isFetching = false;
        isLoading = false;
      });
      return;
    }

    setState(() {
      products = res;
      isFetching = false;
      isLoading = false;
    });
  }

  Future<void> fetchMoreData() async {
    if (isFetching || !hasMoreData || isLoading) return;

    setState(() {
      isFetching = true;
      isMoreFetching = true;
    });

    page++;
    final List<ProductModel>? res = await Api.getPost(page, limit);

    if (res == null || res.isEmpty) {
      setState(() {
        hasMoreData = false;
        isFetching = false;
        isMoreFetching = false;
      });
      return;
    }

    setState(() {
      products.addAll(res);
      isFetching = false;
      isMoreFetching = false;
    });
  }

  Future<void> deleteItem(int id) async {
    setState(() {
      products.removeWhere((product) => product.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Infinity scrolling todo app",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Builder(
          builder: (context) {
            // Initial loading state
            if (isLoading && products.isEmpty && !isRefreshing) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error state
            if (isError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Something went wrong"),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: fetchData,
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            // Empty data state
            if (!hasData) {
              return const Center(child: Text("No data found"));
            }

            // The grid and loader combined
            return CustomScrollView(
              controller: sc,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(5),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = products[index];
                      return ListItem(
                        product: product,
                        onDelete: () {
                          if (product.id != null) {
                            deleteItem(product.id!);
                          }
                        },
                        onEdit: () {
                          Navigator.pushNamed(
                            context,
                            '/update',
                            arguments: {'id': product.id},
                          );
                        },
                      );
                    }, childCount: products.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 0.9,
                        ),
                  ),
                ),

                // Full-width loader (centered) inside scroll
                if (isMoreFetching)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      ),
                    ),
                  ),

                // Full-width “no more data” message
                if (!isMoreFetching && !hasMoreData)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          "No more data",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
