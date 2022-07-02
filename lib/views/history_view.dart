import 'package:dictionary_en_to_en/models/history_model.dart';
import 'package:dictionary_en_to_en/providers/dictionary_state.dart';
import 'package:dictionary_en_to_en/providers/firestore_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  FirestoreState? state;

  @override
  Widget build(BuildContext context) {
    var historys = Provider.of<List<HistoryModel>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: historys.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  print(index);
                  return Container(
                      padding: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${historys[index].word ?? ''}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          GestureDetector(
                              onTap: () => Provider.of<FirestoreState>(context, listen:false).updateHistoryFavorite(historys[index].id!, !historys[index].favorite!),
                              child:  Icon(
                                Icons.favorite,
                                color: historys[index].favorite! ? Colors.red : Colors.black,
                              )
                          )
                        ],
                      )
                  );
                }
            )
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}