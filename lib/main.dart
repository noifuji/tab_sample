import 'package:flutter/material.dart';
const kImageTab1On = 'assets/images/tab1_on.png';
const kImageTab2On = 'assets/images/tab2_on.png';
const kImageTab3On = 'assets/images/tab3_on.png';
const kImageTab1Off = 'assets/images/tab1_off.png';
const kImageTab2Off = 'assets/images/tab2_off.png';
const kImageTab3Off = 'assets/images/tab3_off.png';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final List<List<String>> _tabImages = [
    [kImageTab1On,kImageTab1Off],
    [kImageTab2On,kImageTab2Off],
    [kImageTab3On,kImageTab3Off]];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabImages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: _buildTabTitles(),
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.transparent,),
      ),
      body:  TabBarView(
        controller: _tabController,
        children: const [
          Center(child:Text("1", style: TextStyle(fontSize: 50),),),
          Center(child:Text("2", style: TextStyle(fontSize: 50),),),
          Center(child:Text("3", style: TextStyle(fontSize: 50),),),
        ],
      ),
    );
  }

  List<Widget> _buildTabTitles() {
    return _tabImages.asMap().entries.map((e) {
      final index = e.key;
      final activeImage = e.value[0];//_tabImagesの各要素の0番目に活性画像
      final inactiveImage = e.value[1];//各要素の1番目に非活性画像をいれた。
      return Tab(
          height: 80,
          //タブが切り替わると、タブ内部のアニメーションの値が変化する。
          icon: AnimatedBuilder(animation: _tabController!.animation!, builder: (BuildContext context, Widget? child) {
            return Image(
                    fit: BoxFit.fitWidth,
                    height: 72,
                    //アニメーションに合わせて、活性画像と非活性画像を切り替える。
                    image: (_tabController == null || _tabController!.animation!.value.round() == index)
                        ? AssetImage(activeImage)
                        : AssetImage(inactiveImage),
                );
          },)
      );
    }).toList();
  }
}
