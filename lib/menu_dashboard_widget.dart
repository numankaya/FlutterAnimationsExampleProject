import 'package:flutter/material.dart';

final TextStyle menuFontStyle = TextStyle(color: Colors.white, fontSize: 20);
final Color backgroundColor = Color(0xFF000E44);

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({Key? key}) : super(key: key);

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  late double ekranYuksekligi, ekranGenisligi;
  bool menuAcikMi = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scaleMenuAnimation;
  late Animation<Offset> _menuOffsetAnimation;
  final Duration _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _scaleMenuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _menuOffsetAnimation = Tween(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYuksekligi = MediaQuery.of(context).size.height;
    ekranGenisligi = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            menuOlustur(context),
            dashboardOlustur(context),
          ],
        ),
      ),
    );
  }

  Widget menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dashboard", style: menuFontStyle),
                SizedBox(height: 10),
                Text("Mesajlar", style: menuFontStyle),
                SizedBox(height: 10),
                Text("Utility Bills", style: menuFontStyle),
                SizedBox(height: 10),
                Text("Fund Transfer", style: menuFontStyle),
                SizedBox(height: 10),
                Text("Branches", style: menuFontStyle),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboardOlustur(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: menuAcikMi ? 0.4 * ekranGenisligi : 0,
      right: menuAcikMi ? -0.4 * ekranGenisligi : 0,
      duration: _duration,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: menuAcikMi ? BorderRadius.circular(40) : null,
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                          onTap: (() {
                            setState(() {
                              if (menuAcikMi) {
                                _controller.reverse();
                              } else {
                                _controller.forward();
                              }
                              menuAcikMi = !menuAcikMi;
                            });
                          }),
                          child: Icon(Icons.menu, color: Colors.white)),
                      Text("My Cards",
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                      Icon(Icons.add_circle_outline, color: Colors.white),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 200,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.pink,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.green,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.teal,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Öğrenci $index"),
                          trailing: Icon(Icons.add),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
