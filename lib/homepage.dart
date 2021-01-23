import 'package:flutter/material.dart';
import 'employee.dart';
import 'employeeBloc.dart';

//
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();
  @override
  void dispose() {
    super.dispose();
    _employeeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'EmployeeApp',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: StreamBuilder<List<Employee>>(
            stream: _employeeBloc.employeeListStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color(0xFF252525),
                    //elevation: 5.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            "${snapshot.data[index].id}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data[index].name}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "₹" +
                                    snapshot.data[index].salary
                                        .truncate()
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Column(
                            children: [
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.thumb_up),
                                  color: Colors.blue,
                                  onPressed: () {
                                    _employeeBloc.employeeSalaryIncrement
                                        .add(snapshot.data[index]);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.thumb_down),
                                  color: Colors.white,
                                  onPressed: () {
                                    _employeeBloc.employeeSalaryDecrement
                                        .add(snapshot.data[index]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
