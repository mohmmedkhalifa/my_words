import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_words/models/words.dart';
import 'package:my_words/providers/word_providers.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> fonts = ['Kufa', 'Vibes', 'Harm'];
  var myFont;
  int i = 0;
  String myWord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Text(
            'A',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            setState(() {
              myFont = fonts[i];
              i++;
              if (i == fonts.length) {
                i = 0;
              }
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                    Container(
                      color: Colors.white,
                      height: 430,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 24,
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24),
                                child: TextField(
                                  textDirection: TextDirection.rtl,
                                  onChanged: (value) {
                                    myWord = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'يرجى كتابة كلمتك الجديدة',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              width: 230,
                              height: 60,
                              child: RaisedButton(
                                onPressed: () {
                                  Provider.of<WordProvider>(
                                      context, listen: false)
                                      .insertIntoBookTable(Word(word: myWord));
                                  Navigator.pop(context);
                                },
                                color: Colors.purple,
                                child: Center(
                                  child: Text(
                                    'إضافة',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                ),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              );
            },
          )
        ],
        title: Text(
          'كلماتي',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Consumer<WordProvider>(
        builder: (context, value, child) =>
            Center(
              child: value.words.length == 0
                  ? Text(
                'لا يوجد كلمات مضافة',
                style: TextStyle(fontSize: 30, fontFamily: myFont),
              )
                  : ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: value.words.length,
                itemBuilder: (context, index) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Text(
                        value.words[index].word,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: myFont,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
              ),
            ),
      ),
    );
  }
}
