import 'package:flutter/material.dart';
import 'package:mysuru_toursim/providers/volunteers.dart';
import 'package:mysuru_toursim/widgets/divider_custom.dart';
import 'package:mysuru_toursim/widgets/volunteer_card.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';

class ServicesScreen extends StatefulWidget {
  static const routeName = '/services';

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'title': 'Cab Services'},
      {'title': 'Guide Services'},
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final volunteers = Provider.of<Volunteers>(context).volunteers;
    final cabVolunteers = Provider.of<Volunteers>(context).cabVolunteers;
    final touristVolunteer = Provider.of<Volunteers>(context).tourVolunteers;
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: AppDrawer(),
      body: (_selectedPageIndex == 0)
          ? GridView(
              children: cabVolunteers
                  .map(
                    (volunteer) => VolunteerCard(
                      volunteer.title,
                      volunteer.phone,
                      volunteer.description,
                      volunteer.id,
                    ),
                  )
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 2.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            )
          : GridView(
              children: touristVolunteer
                  .map(
                    (volunteer) => VolunteerCard(
                      volunteer.title,
                      volunteer.phone,
                      volunteer.description,
                      volunteer.id,
                    ),
                  )
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 2.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.local_taxi),
            label: 'Cab Services',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person),
            label: 'Guide Services',
          ),
        ],
      ),
    );
  }
}
