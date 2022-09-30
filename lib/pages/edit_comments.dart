import 'dart:isolate';

import 'package:flutter/widgets.dart';
import 'package:productivo/models/asset_model.dart';
import 'package:flutter/material.dart';
import '../components/styles.dart';
import '../networking/requests.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditComments extends StatefulWidget {
  static const String id = 'EditComments';
  final AssetModel? am;

  const EditComments({Key? key, required this.am}) : super(key: key);

  @override
  _EditComments createState() => _EditComments(am);
}

class _EditComments extends State<EditComments>
    with SingleTickerProviderStateMixin {
  AssetModel? am;

  List<Widget> _newFields = [];
  List<String> _commentsList = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _EditComments(am) {
    this.am = am;
    _commentsList.addAll(this.am!.comments);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text('Edit Comments'),
      ),
      body: _buildBody(),
    );
  }

  List<Widget> merge(List<Widget> l1, List<Widget> l2) {
    List<Widget> x = [];
    x.addAll(l1);
    x.addAll(l2);
    return x;
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Column(
          children: merge(
            merge(_buildTextFields(am!.comments), _newFields),
            [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _newFields.add(
                        TextFormField(
                          onSaved: ((newValue) =>
                              _commentsList.add(newValue.toString())),
                          decoration:
                              const InputDecoration(labelText: 'Comment: '),
                          initialValue: '',
                        ),
                      );
                    });
                  }),
              TextButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    am!.comments = _commentsList;
                    print(_commentsList);
                    Isolate.spawn(Requests().updateCommentsWrapper, am);
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  List<Widget> _buildTextFields(List<String> x) {
    return x.map((comment) {
      return TextFormField(
        decoration: const InputDecoration(labelText: 'Comment: '),
        initialValue: comment,
      );
    }).toList();
  }
}
