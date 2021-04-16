import 'dart:convert';
import 'package:demo/Goods_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  final _formkey = GlobalKey<FormState>();
  Future<List<Goods_data>>? _future;

  @override
  void initState() {
    super.initState();
    _future = getGoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return 'Please enter name';
              },
              decoration:
                  InputDecoration(hintText: 'Enter Name', labelText: 'Name'),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty)
                  return 'Please enter mobile No';
                else if (value!.length != 10)
                  return 'Phone no should be 10 digits';
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  hintText: 'Enter Mobile', labelText: 'Mobile'),
            ),
            RaisedButton(
              onPressed: () {
                // _validate();
              },
              child: Text('Save'),
            ),
            Expanded(
                child: FutureBuilder<List<Goods_data>>(
                    future: _future,
                    builder: (context, mydata) {
                      if (mydata.hasData) {
                        var list = mydata.data!;
                        return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, i) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Text(list[i].name),
                              );
                            });
                      } else if (mydata.hasError)
                        return Text('${mydata.error}');
                      else
                        return CupertinoActivityIndicator();
                    }))
          ],
        ),
      ),
    );
  }

  Future<List<Goods_data>> getGoods() async {
    //if (_formkey.currentState.validate()) {
    var url =
        'https://laravel.gowebbidemo.com/122282/public/api/v1/user/get-goods';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body);
      var myjson = jsonDecode(response.body);
      Goods_Model model = Goods_Model.fromJson(myjson);
      if (model.status == 'success') {
        return model.dataList;
      } else
        throw 'No data';
    } else
      throw 'Error';
    // }
  }
}
