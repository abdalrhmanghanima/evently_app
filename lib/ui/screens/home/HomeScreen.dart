import 'package:evently_app/extensions/context_extension.dart';
import 'package:evently_app/routes.dart';
import 'package:evently_app/ui/providers/AppAuthProvider.dart';
import 'package:evently_app/ui/screens/home/tabs/fav/fav.dart';
import 'package:evently_app/ui/screens/home/tabs/home_tab/home_tab.dart';
import 'package:evently_app/ui/screens/home/tabs/map/maps_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentBottomNavIndex = 0;
  late List<Widget> tabs;
  @override
  void initState() {
    super.initState();
    tabs = [
      HomeTab(),
      GoogleMapsTab(),
      FavTab(),
      HomeTab(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    AppAuthProvider provider = Provider.of<AppAuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    var user = provider.getUser();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              provider.logout();
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.LoginScreen.name,
              );
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        centerTitle: false,
        backgroundColor: context.appColors.primary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user?.name?.isEmpty == false) ...[
              Text(
                "welcome back",
                style: context.fonts.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 17,
                ),
              ),
              Text(
                user?.name ?? "",
                style: context.fonts.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/map.svg'),
                  SizedBox(height: 8),
                  Text(
                    'Cairo',
                    style: context.fonts.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                ],
              ),
            ] else
              CircularProgressIndicator(),
          ],
        ),
        toolbarHeight: 120,
      ),
      body: Column(
        children: [
          Expanded(child: tabs[currentBottomNavIndex]),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(useMaterial3: false),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: context.appColors.primary,
          notchMargin: 5,
          child: BottomNavigationBar(
            backgroundColor: context.appColors.primary,
            currentIndex: currentBottomNavIndex,
            showSelectedLabels: true,
            onTap: (index) {
              setState(() {
                currentBottomNavIndex = index;
              });
            },
            showUnselectedLabels: true,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/home.svg'),
                label: 'Home',
                activeIcon: SvgPicture.asset('assets/icons/home_fill.svg'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/map.svg'),
                label: 'Maps',
                activeIcon: SvgPicture.asset('assets/icons/maps_fill.svg'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/heart.svg'),
                label: 'Favourite',
                activeIcon: SvgPicture.asset('assets/icons/heart_fill.svg'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/user.svg'),
                label: 'Profile',
                activeIcon: SvgPicture.asset('assets/icons/user_fill.svg'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(360),
          side: BorderSide(color: Colors.white, width: 4),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.AddEvent.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

//[1 , 2 ,3] [4 , 5 , 6] => [1,2,3,4,5,6]
//[1,2,3,...[4,5,6]] -> [1,2,3,4,5,6]