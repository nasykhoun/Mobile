import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'student_form.dart';


import 'student_model.dart';
import 'student_service.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late Future<StudentModel> _futureStudent;

  @override
  void initState() {
    super.initState();
    _futureStudent = StudentService.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Student Screen"),
        actions: [
          IconButton(
            onPressed: () async {
              bool edited = await Navigator.of(
                context,
              ).push(
                CupertinoPageRoute(builder: (context) => StudentForm()),
              );
              if (edited) {
                setState(() {
                  _futureStudent = StudentService.read();
                });
              }
            },
            icon: Icon(Icons.person_add),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }


  Widget _testBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInsert(),
          _buildUpdate(),
          _buildDelete(),
          _buildOutput(),
        ],
      ),
    );
  }

  String _output = "output:";

  Widget _buildInsert() {
    return ElevatedButton(
      onPressed: () {
        Datum item = Datum(
          id: 0,
          latinName: "Test 1",
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );

        StudentService.insert(item)
            .then((value) {
          setState(() {
            _output = value.toString();
          });
        })
            .onError((e, s) {
          setState(() {
            _output = e.toString();
          });
        });
      },
      child: Text("INSERT"),
    );
  }

  Widget _buildUpdate() {
    return ElevatedButton(
      onPressed: () {
        Datum item = Datum(
          id: 1,
          latinName: "Test 1",
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );

        StudentService.update(item)
            .then((value) {
          setState(() {
            _output = value.toString();
          });
        })
            .onError((e, s) {
          setState(() {
            _output = e.toString();
          });
        });
      },
      child: Text("UPDATE"),
    );
  }

  Widget _buildDelete() {
    return ElevatedButton(
      onPressed: () {
        StudentService.delete(2)
            .then((value) {
          setState(() {
            _output = value.toString();
          });
        })
            .onError((e, s) {
          setState(() {
            _output = e.toString();
          });
        });
      },
      child: Text("DELETE"),
    );
  }

  Widget _buildOutput() {
    return Text(_output);
  }

  Widget _buildBody() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _futureStudent = StudentService.read();
          });
        },
        child: FutureBuilder<StudentModel>(
          future: _futureStudent,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _buildError(snapshot.error);
            }

            if (snapshot.connectionState == ConnectionState.done) {
              debugPrint("model = ${snapshot.data}");

              return _buildDataModel(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDataModel(StudentModel? model) {
    if (model == null) {
      return SizedBox();
    }

    return _buildListView(model.data);
  }

  Widget _buildError(Object? error) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error),
          Text(error.toString()),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _futureStudent = StudentService.read();
              });
            },
            icon: Icon(Icons.refresh),
            label: Text("RETRY"),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<Datum> items) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        debugPrint("item = $item");
        return Dismissible(
          key: UniqueKey(),
          child: Card(
            child: ListTile(
              title: Text(item.latinName ?? "No Name"),
              subtitle: Text(
                item.khmerName ?? "No Khmer Name",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),

              onTap: () async {
                bool edited = await Navigator.of(
                  context,
                ).push(
                  CupertinoPageRoute(
                    builder: (context) => StudentForm(item: item,editMode: true),
                  ),
                );
                if (edited) {
                  setState(() {
                    _futureStudent = StudentService.read();
                  });
                }
              },
              // subtitle: Text(item.updatedAt),
            ),
          ),
        );
      },
    );
  }

}