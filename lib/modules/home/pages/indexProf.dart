import 'package:abntplaybic/modules/home/pages/telas/inicio.dart';
import 'package:abntplaybic/modules/home/pages/telas/perfil_page.dart';
import 'package:abntplaybic/modules/home/pages/telas/turmasPage.dart';
import 'package:abntplaybic/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'telas/tutorial_professor.dart';

class HomePageProf extends StatefulWidget {
  const HomePageProf({super.key});

  @override
  State<HomePageProf> createState() => _HomePageProfState();
}

class _HomePageProfState extends State<HomePageProf> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    InicioPage(),
    TurmasPage(),
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
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onItemTapped,
            scrollDirection: Axis.horizontal,
            children: _widgetOptions,
          ),
          Positioned(
            top: 10.0, // Posição do botão
            right: 10.0, // Posição do botão
            child: IconButton(
              onPressed: () {
                // Redireciona para a página TutorialProfessorPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TutorialProfessorPage()),
                );
              },
              icon: Icon(Icons.help, color: Colors.green), // Ícone para o botão de tutorial
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          items: [
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
                  MdiIcons.viewList,
                  color: roxo,
                  size: 35,
                ),
                icon: Icon(
                  MdiIcons.viewListOutline,
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
