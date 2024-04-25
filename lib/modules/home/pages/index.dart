import 'package:abntplaybic/modules/home/pages/telas/classificacao.dart';
import 'package:abntplaybic/modules/home/pages/telas/conquistas.dart';
import 'package:abntplaybic/modules/home/pages/telas/inicio.dart';
import 'package:abntplaybic/modules/home/pages/telas/perfil_page.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    InicioPage(),
    ClassificacaoPage(),
    ConquistasPage(),
    PerfilPage(),
  ];

  final PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTapped,
        scrollDirection: Axis.horizontal,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(
                  MdiIcons.home,
                  color: roxo,
                  size: 35,
                ),
                icon: Icon(
                  MdiIcons.homeOutline,
                  color: lilas,
                ),
                label: ""),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  MdiIcons.signalCellular3,
                  color: roxo,
                  size: 35,
                ),
                icon: Icon(
                  MdiIcons.signalCellularOutline,
                  color: lilas,
                ),
                label: ""),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  MdiIcons.medal,
                  color: roxo,
                  size: 35,
                ),
                icon: Icon(
                  MdiIcons.medalOutline,
                  color: lilas,
                ),
                label: ""),
            BottomNavigationBarItem(
                activeIcon: Icon(
                  MdiIcons.account,
                  color: roxo,
                  size: 35,
                ),
                icon: Icon(
                  MdiIcons.accountOutline,
                  color: lilas,
                ),
                label: ""),
          ]),
    );
  }
}
