import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_project/model.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class ViewTickets extends StatefulWidget {
  const ViewTickets({Key? key}) : super(key: key);

  @override
  State<ViewTickets> createState() => _ViewTicketsState();
}

class _ViewTicketsState extends State<ViewTickets> {
  List<String> docIds = [];

  // get document and add to docList
  Future getDocId() async {
    // docIds.clear();
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              // looping through documents
              docIds.add(document.reference.id); //adding document to the list
              // print(docIds.length);
            },
          ),
        );
  }

  //get the data from the database and map
  Stream<List<UserDetail>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserDetail.fromJson(doc.data())).toList());

  //build the list
  Widget buildUser(UserDetail user) {
    print(docIds);
    var index = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text('D')),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              // user.id = FirebaseFirestore.instance
              //     .collection('users')
              //     .doc()
              //     .id;
              // print(user.id);
              getDocId();
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(docIds[index])
                  .delete();
              docIds.removeAt(index);
              index++;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('You have successfully deleted a product')));
            },
          ),
          title: Text(
              "Document[${user.documentNumber}] found at ${user.placeFound}."),
          subtitle: Text(user.fullName),
          tileColor: Colors.grey[300],
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ListViewClick()));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: StreamBuilder<List<UserDetail>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong... ${snapshot.error}');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(
                  children: users.map<Widget>(buildUser).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class ListViewClick extends StatelessWidget {
  const ListViewClick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Image'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: SizedBox(
          height: 300,
          child: Image.asset('assets/license.jpg'),
        ),
      ),
    );
  }
}
