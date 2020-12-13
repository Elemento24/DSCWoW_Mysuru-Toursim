import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/volunteers.dart';
// import '../providers/auth.dart';

class EditProfileCard extends StatefulWidget {
  @override
  _EditProfileCardState createState() => _EditProfileCardState();
}

class _EditProfileCardState extends State<EditProfileCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _descFN = FocusNode();
  final _phoneFN = FocusNode();
  var _isError = false;
  var _isLoading = false;
  Map<String, Object> _data = {
    'title': '',
    'description': '',
    'phone': '',
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Volunteers>(context).setDetails();
    final det = Provider.of<Volunteers>(context).volDetails;
    _data = det;
  }

  @override
  void dispose() {
    super.dispose();
    _descFN.dispose();
    _phoneFN.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Volunteers>(context, listen: false).updateVolunteer(
        title: _data['title'],
        description: _data['description'],
        phone: _data['phone'],
      );
      _isError = false;
      Provider.of<Volunteers>(context, listen: false).setDetails();
    } catch (error) {
      const errorMessage = 'Some Error Occured! Please try again later!';
      print(errorMessage);
      _isError = true;
    }

    // Quick Fix
    if (!_isError) Navigator.of(context).pushReplacementNamed('/');

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              child: Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.black,
              ),
              alignment: Alignment.topCenter,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: _data['title'],
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title),
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter the Title for the Service';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descFN);
                    },
                    onSaved: (value) {
                      _data['title'] = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: _data['description'],
                    focusNode: _descFN,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter a Description';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_phoneFN);
                    },
                    onSaved: (value) {
                      _data['description'] = value;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    initialValue: _data['phone'],
                    focusNode: _phoneFN,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Contact Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your Contact Number!';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      // FocusScope.of(context).requestFocus(_passwordFN);
                    },
                    onSaved: (value) {
                      _data['phone'] = value;
                    },
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : FloatingActionButton.extended(
                          onPressed: _submit,
                          label: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: Icon(Icons.login, color: Colors.black),
                          heroTag: null,
                          elevation: 2,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
