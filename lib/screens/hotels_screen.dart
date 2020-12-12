import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './hotel_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/hotel_card.dart';
import '../providers/hotels.dart';

class HotelsScreen extends StatefulWidget {
  static const routeName = '/hotels';

  @override
  _HotelsScreenState createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Hotels>(context).fetchAndSetHotels().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final hotels = Provider.of<Hotels>(context).hotels;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotels',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 24,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: hotels.map(
                  (el) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          HotelScreen.routeName,
                          arguments: el.id,
                        );
                      },
                      child: HotelCard(el.hotelName, el.imgUrl, el.rating),
                    );
                  },
                ).toList(),
              ),
            ),
    );
  }
}
