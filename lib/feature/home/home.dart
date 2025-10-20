import 'package:flutter/material.dart';
import 'package:flutter_todo_app/feature/home/api.dart';
import 'package:flutter_todo_app/feature/home/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

const int limit = 20;
int page = 1;

class _HomeState extends State<Home> {
  final ScrollController sc = ScrollController();
  List<PostModel> posts = [];
  bool isLoading = false;
  bool isRefreshing = false;
  bool isMoreFetching = false;
  bool isFetching = false;
  bool isError = false;
  bool hasMoreData = true;
  bool hasData = true;

  @override
  void initState() {
    fetchData();
    sc.addListener(() {
      if (sc.position.pixels >= sc.position.maxScrollExtent) {
        fetchMoreData();
      }
    });
    super.initState();
  }

  Future<void> refresh() async {
    isRefreshing = true;
    await fetchData();
    isRefreshing = false;
  }

  Future<void> fetchData() async {
    if (isFetching || !hasData || !hasMoreData) {
      return;
    }
    setState(() {
      isLoading = true;
      isFetching = true;
    });
    page = 1;

    List<PostModel>? res = await Api.getPost(page, limit);
    if (res != null) {
      if (res.isEmpty) {
        setState(() {
          hasData = false;
          isFetching = false;
          isLoading = false;
        });
        return;
      }
      setState(() {
        posts.addAll(res);
        isFetching = false;
        isLoading = false;
      });
      return;
    }
    setState(() {
      isError = true;
      isFetching = false;
      isLoading = false;
    });
  }

  Future<void> fetchMoreData() async {
    if (isFetching || !hasMoreData) {
      return;
    }
    setState(() {
      isFetching = true;
      isMoreFetching = true;
    });
    page = page + 1;

    List<PostModel>? res = await Api.getPost(page, limit);
    if (res != null) {
      if (res.isEmpty) {
        setState(() {
          hasMoreData = false;
          isFetching = false;
          isMoreFetching = false;
        });
        return;
      }
      setState(() {
        posts.addAll(res);
        isFetching = false;
        isMoreFetching = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TODO App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: false,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: sc,
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: posts.isEmpty ? 1 : posts.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (posts.isEmpty) {
              if (isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (isError) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text("Something went wrong")),
                );
              }
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text("No data found")),
              );
            }
            if (index < posts.length) {
              final post = posts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Id: ${post.id}"),
                    Text("User id: ${post.userId}"),
                    Text("Title: ${post.title}"),
                  ],
                ),
              );
            }
            if (!hasMoreData) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text("No more data", textAlign: TextAlign.center),
              );
            }
            if (isMoreFetching) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
