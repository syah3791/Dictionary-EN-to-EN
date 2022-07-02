import 'package:dictionary_en_to_en/firebase_options.dart';
import 'package:dictionary_en_to_en/providers/dictionary_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => DictionaryState(context),
          ),
        ],
        child:MaterialApp(
          title: 'Dictionary',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Dictionary'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DictionaryState? state;
  void _incrementCounter() {
    state!.getWord('word');
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<DictionaryState>(context, listen:false);
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => DictionaryState(context))
    ],
      child: Consumer(
        builder: (BuildContext context, DictionaryState state, Widget? child){
          this.state = state;
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                        controller: state.controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                      ),
                        onSubmitted:(val) => state.getWord(val)
                    ),
                   TextButton(
                       onPressed: ()  => state.getWord(state.controller.text),
                       child: Text(
                         'Search',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 20.0,
                         ),
                       ),
                   ),
                   SizedBox(height: 8,),
                    Text(
                      'Word:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      '   ${state.wordData.word ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      '   ${state.wordData.phonetic ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'Meaning:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),

                    state.wordData.meanings == null ? Container(): ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.wordData.meanings!.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          print(index);
                          return Container(
                              padding: EdgeInsets.all(4),
                              child: Column(
                                children: [
                                  Text(
                                    '${state.wordData.meanings![index].partOfSpeech ?? ''}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  ListView.builder(
                                      physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.wordData.meanings![index].definitions!.length,
                                  itemBuilder: (BuildContext ctxt, int index2) {
                                    return Container(
                                        padding: EdgeInsets.all(4),
                                        margin: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.black12.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                      ),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Definition',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Text(
                                              '${state.wordData.meanings![index].definitions![index2].definition ?? ''}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Text(
                                              'Example',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Text(
                                              '${state.wordData.meanings![index].definitions![index2].example ?? ''}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        )
                                    );
                                  }
                              ),

                                ],
                              )
                          );
                        }
                    )
                  ],
                ),
              )
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
  }
}
