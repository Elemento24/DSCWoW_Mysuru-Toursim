import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/volunteers.dart';
import '../providers/auth.dart';

class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _descFN = FocusNode();
  final _phoneFN = FocusNode();
  var _isLoading = false;
  var _isError = false;
  Map<String, Object> _data = {
    'title': '',
    'description': '',
    'phone': '',
    'isCab': true,
  };

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
      await Provider.of<Volunteers>(context, listen: false).addVolunteer(
        title: _data['title'],
        description: _data['description'],
        phone: _data['phone'],
        isCab: _data['isCab'],
      );
      _isError = false;
      Provider.of<Auth>(context, listen: false).setHasCreatedProfile();
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
    final hasCreatedprofile =
        Provider.of<Auth>(context, listen: false).hasCreatedProfile;

    if (hasCreatedprofile) {
      Provider.of<Volunteers>(context, listen: false).getDetails();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              child: Icon(
                Icons.account_circle,
                size: 80,
                color: Colors.black,
              ),
              alignment: Alignment.topCenter,
            ),
            SizedBox(height: 20),
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
                  SwitchListTile(
                    title: _data['isCab']
                        ? Text(
                            'Cab Service',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : Text(
                            'Tourist Guide',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                    value: _data['isCab'],
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (arg) {
                      setState(() {
                        _data['isCab'] = arg;
                      });
                    },
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : FloatingActionButton.extended(
                          onPressed: _submit,
                          label: Text('Create Profile',
                              style: TextStyle(color: Colors.black)),
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
