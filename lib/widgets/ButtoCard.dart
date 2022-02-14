import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class  BtnCard extends StatefulWidget {
  @override
  _BtnCardState createState() => _BtnCardState();
}

class _BtnCardState extends State< BtnCard> {
   bool visibilityTag = false;

    void _changed(bool visibility, String field) {
    setState(() {
      if (field == "tag"){
        visibilityTag = visibility;
      }
    });
  }
  @override
  
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:60.0),
      child: Column(
        children:[
           visibilityTag ? new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Expanded(
                      flex: 4,
                      child: new Card(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5.0),
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Text(
                    'Meu nome é Yuri, estou no mundo da luta há 15 anos. Pratico kung fu e estou aceitando qualquer desafio que esteja perto de mim.',
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.anton(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new IconButton(
                        color: Colors.grey[400],
                        icon: const Icon(Icons.cancel, size: 22.0,),
                        onPressed: () {
                          _changed(false, "tag");
                        },
                      ),
                    ),
                  ],
                ) : new Container(),
                Row(
                  children: [
                   new SizedBox(width: 24.0),
              new InkWell(
                onTap: () {
                  visibilityTag ? null : _changed(true, "tag");
                },
                child: new Container(
                  margin: new EdgeInsets.only(top: 16.0),
                  child: new Column(
                    children: <Widget>[
                      
                      new Icon(Icons.account_circle_rounded , color: visibilityTag ? Colors.transparent : Colors.grey[600],
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        padding: EdgeInsets.only(left:180.0),
                      ),
                    ],
                ),
                ),
              )
                  ],
                ),
        ],
      ),
      
    );
  }
}
 