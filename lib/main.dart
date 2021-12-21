import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'I am transparent'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(.6),
        title: Text(widget.title),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            const _Card(
              text: 'try changing extendBodyBehindAppBar to false',
              color: Colors.purple,
            ),
            _SampleListView(),
            const _Card(
              text: 'try changing extendBodyBehindAppBar to false',
              color: Colors.lightBlue,
            ),
            const _Card(
              text: 'It will then work as expected',
              color: Colors.orangeAccent,
            ),
            const _Card(text: 'Sample Content', color: Colors.green),
            const _Card(text: 'Sample Content', color: Colors.pink),
            const _Card(text: 'Sample Content', color: Colors.yellow),
            const _Card(text: 'Sample Content', color: Colors.amber),
          ],
        ),
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

class _Card extends StatelessWidget {
  final String text;
  final Color color;

  const _Card({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(20),
      color: color,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}

class _SampleListView extends StatelessWidget {
  final items = List<String>.generate(2, (i) => "I should be up $i");

  _SampleListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          width: double.maxFinite,
          height: 200,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
