import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('FK07'),
        ),
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int index) => new EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const [], this.info = const <String,String>{}]);
  final String title;
  List<Entry> children;
  final Map<String,String> info;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  new Entry('Tecnical Writing',
    <Entry>[
      new Entry('Info',[],<String,String>{"ECTS":"5","SWS":"4","lecturer":"Dr. phil. Aniko Balazs", }),
      new Entry('Details',
          <Entry>[
            new Entry('Info',[],<String,String>{"Course objective":"Enable participants to produce technical documents according to the"+
            "English language writing standards. > Sensitise students for the need of document usability and readability."+
            "> Provide students with the tools necessary to write and revise their documents effectively",
              "Prerequisites":"Profound knowledge in English (intermediate -- post-intermediate)","Recommended reading":
              "> Rechenberg, P., \"Technisches Schreiben (nicht nur) fuer Informatiker\", 2nd ed., Muenchen-Wien: Hanser, 2003."
            + "> Gopen, G. D. and Swan, J. A., \"The Science of Scientific Writing,\" American Scientist, vol. 78, pp. 550-558, Nov.1990."+
              "> Knuth, D.E. et al., \"Mathematical Writing\", MAA Notes, no. 14, The Mathematical Association of America, 1989", }),
          ],),
      new Entry('Section A2'),
    ],
  ),
  new Entry('Chapter B',
    <Entry>[
      new Entry('Section B0'),
      new Entry('Section B1'),
    ],
  ),
  new Entry('Chapter C',
    <Entry>[
      new Entry('Section C0'),
      new Entry('Section C1'),
      new Entry('Section C2',
        <Entry>[
          new Entry('Item C2.0'),
          new Entry('Item C2.1'),
          new Entry('Item C2.2'),
          new Entry('Item C2.3'),
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
    if (root.children.isEmpty&&root.info==null)
      return new ListTile(title: new Text(root.title));
    if (root.children.isEmpty&&root.info.isNotEmpty){
      Iterable<String> keys = root.info.keys;
      List<TableRow> rows = new List();
      keys.forEach((x) => rows.add(new TableRow(children: [new Text(x),new Text(root.info[x])])));
      return new Table(
        children: rows,
      );
    }
    return new ExpansionTile(
      key: new PageStorageKey<Entry>(root),
      title: new Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(new ExpansionTileSample());
}
