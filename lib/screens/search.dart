import 'dart:async';
import 'dart:convert';

import 'package:covid19/widgets/search_item.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _url = "https://covid19.mathdro.id/api/countries/";
  String _summaryUrl = "https://covid19.mathdro.id/api/countries/";
  String _searchKey = '';
  String _value;

  TextEditingController _controller = TextEditingController();
  StreamController _streamController;
  Stream _stream;

  Timer _debounce;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      _streamController.add(null);
      return;
    }

    _streamController.add('waiting');
    Response response = await get(
      _url + _controller.text,
    );

    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Search ',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 5.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: _controller,
                      onChanged: (String text) {
                        if (_debounce?.isActive ?? false) _debounce.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () {
                          _search();
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        // suffixIcon: IconButton(
                        //     icon: Icon(Icons.search),
                        //     onPressed: () {
                        //       _search();
                        //     }),
                        hintText: 'Enter a country i.e US, United kingdom',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5.3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5.3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                stream: _stream,
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 100.0,
                          ),
                          SizedBox(height: 30.0),
                          Text(
                              'You can search for a country to see the current stats ')
                        ],
                      ),
                    );
                  }

                  if (snapshot.data == 'waiting') {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data['confirmed'] == null) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.cancel,
                            color: Colors.grey,
                            size: 100.0,
                          ),
                          SizedBox(height: 30.0),
                          Text('Oops, no data found ! Enter a valid country '),
                          SizedBox(height: 30.0)
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        SearchItem(
                            url: '${_summaryUrl + _controller.text + '/og'}',
                            confirmed: '${snapshot.data['confirmed']['value']}',
                            recovered: '${snapshot.data['recovered']['value']}',
                            deaths: '${snapshot.data['deaths']['value']}',
                            country: _controller.text.toUpperCase(),
                            lastUpdated: '${snapshot.data['lastUpdate']}'),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
