import 'package:flutter/material.dart';

class ExpandingFaculty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: const Text('FK07'),
          actions: <Widget>[
            new Image.asset(
              'images/logo.bmp',
              width: 75.0,
              height: 75.0,
              fit: BoxFit.cover,
          ),
        ]),
        body: new Padding(
          padding: new EdgeInsets.all(5.0),
          child: new ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                new EntryItem(data[index]),
            itemCount: data.length,
          ),
        ),
      );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry{
  Entry(this.title, this.likeable,
      [this.children = const [], this.info = const <String, String>{}]);

  final String title;
  List<Entry> children;
  final Map<String, String> info;
  final bool likeable;
  bool liked = false;

}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  new Entry(
    'Tecnical Writing', true,
    <Entry>[
      new Entry('Info',false, [], <String, String>{
        "ECTS": "5",
        "SWS": "4",
        "lecturer": "Dr. phil. Aniko Balazs",
      }),
      new Entry(
        'Details',false,
        <Entry>[
          new Entry('Info',false, [], <String, String>{
            "Course objective":
                "Enable participants to produce technical documents according to the" +
                    "English language writing standards. > Sensitise students for the need of document usability and readability." +
                    "> Provide students with the tools necessary to write and revise their documents effectively",
            "Prerequisites":
                "Profound knowledge in English (intermediate -- post-intermediate)",
            "Recommended reading":
                "> Rechenberg, P., \"Technisches Schreiben (nicht nur) fuer Informatiker\", 2nd ed., Muenchen-Wien: Hanser, 2003." +
                    "> Gopen, G. D. and Swan, J. A., \"The Science of Scientific Writing,\" American Scientist, vol. 78, pp. 550-558, Nov.1990." +
                    "> Knuth, D.E. et al., \"Mathematical Writing\", MAA Notes, no. 14, The Mathematical Association of America, 1989",
          }),
        ],
      ),
    ],
  ),
  new Entry(
    'Operating Systems 1',true,
    <Entry>[
      new Entry('Info',false, [], <String, String>{
        "ECTS": "5",
        "SWS": "4",
        "lecturer": "Dr. phil. Aniko Balazs",
      }),
      new Entry(
        'Details',false,
        <Entry>[
          new Entry('Info', false,[], <String, String>{
            "Course objective":
                "Enable participants to produce technical documents according to the" +
                    "English language writing standards. > Sensitise students for the need of document usability and readability." +
                    "> Provide students with the tools necessary to write and revise their documents effectively",
            "Prerequisites":
                "Profound knowledge in English (intermediate -- post-intermediate)",
            "Recommended reading":
                "> Rechenberg, P., \"Technisches Schreiben (nicht nur) fuer Informatiker\", 2nd ed., Muenchen-Wien: Hanser, 2003." +
                    "> Gopen, G. D. and Swan, J. A., \"The Science of Scientific Writing,\" American Scientist, vol. 78, pp. 550-558, Nov.1990." +
                    "> Knuth, D.E. et al., \"Mathematical Writing\", MAA Notes, no. 14, The Mathematical Association of America, 1989",
          }),
        ],
      ),
    ],
  ),
  new Entry(
    'Event Driven Systems',true,
    <Entry>[
      new Entry('Info', false,[], <String, String>{
        "ECTS": "5",
        "SWS": "4",
        "lecturer": "Dr. phil. Aniko Balazs",
      }),
      new Entry(
        'Details',true,
        <Entry>[
          new Entry('Info',false, [], <String, String>{
            "Sed cursus": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed cursus mauris quis diam porttitor varius." +
                " Cras egestas, quam non tempor commodo, metus nisi elementum leo, et ultrices enim leo pulvinar justo." +
                " Cras condimentum rhoncus lacinia. Sed ultrices efficitur ipsum, ut imperdiet tortor bibendum eget. " +
                "Curabitur nec luctus libero. Donec eu ante mi. Suspendisse diam tortor, fringilla non vestibulum eu, " +
                "tristique eu quam. Maecenas consequat convallis velit id suscipit. Proin blandit imperdiet dolor, ut" +
                " varius orci faucibus at. Sed quis cursus eros. Proin eu neque massa. ",
          }),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty && root.info == null)
      return new ListTile(title: new Text(root.title));
    if (root.children.isEmpty && root.info.isNotEmpty) {
      Iterable<String> keys = root.info.keys;
      List<TableRow> rows = new List();
      for (String s in keys) {
        rows.add(new TableRow(children: [
          new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new Text(s,
                  style: new TextStyle(
                      fontSize: 17.0, fontWeight: FontWeight.bold)))
        ]));
        rows.add(new TableRow(children: [
          new Padding(
              padding: new EdgeInsets.all(4.0),
              child:
                  new Text(root.info[s], style: new TextStyle(fontSize: 14.0)))
        ]));
      }
      return new Table(
        children: rows,
        border: new TableBorder.all(),
      );
    }
    return new ExpansionTile(
      key: new PageStorageKey<Entry>(root),
      title: new Text(root.title),
      children: root.children.map(_buildTiles).toList(),
      trailing:   root.likeable ? new MaterialButton(onPressed: null,
       child: new Icon(
       root.liked ? Icons.favorite : Icons.favorite_border,
       color: root.liked ? Colors.red : null,)):null ,
//      trailing: root.likeable
//          ?  new MaterialButton(onPressed: null,
//       child: new Icon(
//        root.liked ? Icons.favorite : Icons.favorite_border,
//        color: root.liked ? Colors.red : null,)) : null,


    );
  }


  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }

}
//class entryState extends State<Entry> {
//  bool _isFavorited = false;
//
//  void _toggleFavorite() {
//    setState(() {
//      // If the lake is currently favorited, unfavorite it.
//      if (_isFavorited) {
//        _isFavorited = false;
//        // Otherwise, favorite it.
//      } else {
//        _isFavorited = true;
//      }
//    });
//    @override
//    Widget build(BuildContext context) {
//
//       return new Entry(title, likeable)
//  }
//
//class Configuration extends InheritedWidget {
//  final String myConf;
//
//  const Configuration({this.myConf, Widget child}): super(child: child);
//
//  @override
//  bool updateShouldNotify(Configuration oldWidget) {
//    return myConf != oldWidget.myConf;
//  }
//}


class FacultyEntry {
  final int id;
  final String name;
  final String shorthand;
  final Color background;

  FacultyEntry(this.id, this.name, this.shorthand, this.background);
}

class FacultyWidget extends StatelessWidget {
  final FacultyEntry facultyEntry;

  const FacultyWidget(this.facultyEntry);

  Widget _buildWidget(BuildContext context) {
    return new SizedBox(
      height: 250.0,
      child: new Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[new Expanded(
        child: new Container(
          child: new Card(
            color: facultyEntry.background.withOpacity(0.5),
            elevation: 3.0,
            child: new FlatButton(
              onPressed:() { Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => new ExpandingFaculty())
                );
              },
              child: new Column (
                children:<Widget>[
                new Container(
                  padding: new EdgeInsets.all(15.0),
                  child: new Text(
                  facultyEntry.shorthand,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 45.0,
                    color: Colors.black54,
                    fontStyle: FontStyle.normal
                    )
                  )
                ),
                new Container(
                  child: new Text(
                  facultyEntry.name,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 30.0,
                    color: Colors.black54,
                    fontStyle: FontStyle.normal
                    )
                  )
                  )
              ]
              )
            )
            )
          )
        )]
        )
        );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

}

class FacultiesView extends StatelessWidget{

  final List<FacultyEntry> _facultiesList;

  const FacultiesView(this._facultiesList);

  Widget _buildWidget(){
    return new Container(
        color: Colors.blueGrey[100],
        child: new ListView(
        padding: const EdgeInsets.all(10.0),
        children: _facultiesList
        .map((e) => new FacultyWidget(e)).toList()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }
}

class FacultyListView extends StatelessWidget {

  static final facultyEntry0 = new FacultyEntry(1, "Computer Science and Mathematics", "FK07", Colors.blue[400]);
  static final facultyEntry1 = new FacultyEntry(1, "Electrical Engineering and Information Technology", "FK04", Colors.green[400]);
  static final facultyEntry2 = new FacultyEntry(1, "Mechanical, Automotive and Aeronautical Engineering", "FK03", Colors.red[400]);
  static final facultyEntry3 = new FacultyEntry(1, "Applied Sciences and Mechatronics", "FK06", Colors.deepOrange[400]);
  List<FacultyEntry> faculties = [facultyEntry0, facultyEntry1, facultyEntry2, facultyEntry3];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueGrey[700].withOpacity(0.8),
          title: const Text('CiE Prototype'),
          actions: <Widget>[
            new Image.asset(
              'images/logo.bmp',
              width: 75.0,
              height: 75.0,
              fit: BoxFit.cover,
          ),
        ]
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child : new FacultiesView(faculties)
            )
          ]
          )
      ),
    );
  }
}

void main() {
    runApp(new MaterialApp (
          title: "Team3 Prototype",
          home: new FacultyListView()
          )
        );
}

