import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softwareviewer/screens/components/computers.dart';


class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 1;
  PageController _pageController;
  final List<String> titles = [
    'Profile',
    'COMPUTERS',
    'Find computers with software'
  ];
  String currentTitle;

  final List<Color> colors = [
    Colors.purple,
    Colors.green,
    Colors.blue,
  ];
  Color currentColor;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex, keepPage: false);
    currentTitle = titles.elementAt(_currentIndex);
    currentColor = colors.elementAt(_currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: currentColor,
          title: Text(
            currentTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
          centerTitle: true,
          ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
                currentTitle = titles.elementAt(index);
                currentColor = colors.elementAt(index);
              });
            },
            children: <Widget>[
              Container(child: null,),
              Container(child: ComputersList(),),
              Container(child: null,),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Refresh',
          child: Icon(Icons.refresh),
          elevation: 2.0,
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
              currentTitle = titles.elementAt(index);
              currentColor = colors.elementAt(index);
            });
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Profile"),
              textAlign: TextAlign.center,
              activeColor: colors.elementAt(0),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.computer),
              title: Text('Computers'),
              textAlign: TextAlign.center,
              activeColor: colors.elementAt(1),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text('Find'),
              textAlign: TextAlign.center,
              activeColor: colors.elementAt(2),
            ),
          ],
        ),
      ),
    );
  }
}
