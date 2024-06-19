import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/Mess/add_meal.dart';
import 'package:messmanager/Mess/mess_information.dart';
import 'package:rxdart/rxdart.dart';

class MessMembersDetails extends StatefulWidget {
  const MessMembersDetails({super.key});

  @override
  State<MessMembersDetails> createState() => _MessMembersDetailsState();
}

class _MessMembersDetailsState extends State<MessMembersDetails> {
  MessDetails messDetails = MessDetails();
  AddMeal addMeal = AddMeal();
  int indexOfMember = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: StyleOfBackground.backgroundColor),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: addMeal.getMessMemberList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List member = snapshot.data!.docs;
                    return CarouselSlider.builder(
                        itemCount: member.length,
                        itemBuilder: (context, index, realIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 82, 147, 163),
                                    boxShadow: [boxShadow2],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Expanded(
                                        flex: 6,
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 50,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: Center(
                                              child: Text(
                                                  member[index]['userName'])))
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  indexOfMember = index;
                                });
                              },
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          initialPage: 0,
                        ));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: streamBuilderForMemberDetails(
                'Meal_Table',
                'Monthly_meal_table',
                'Meal',
                'Cost_Table',
                'Monthly_cost_table',
                'Cost',
                'Mess_Member_table'),
          )
        ],
      ),
    );
  }

  StreamBuilder<CombinedData3> streamBuilderForMemberDetails(
    String mealTableName,
    String monthlyMealTableName,
    String meal,
    String costTableName,
    String monthlyCostTableName,
    String cost,
    String messMemberTableName,
  ) {
    MessDetails messDetails = MessDetails();
    AddMeal addMeal = AddMeal();
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream1 = messDetails
        .getMessInfo(mealTableName, monthlyMealTableName, meal, DateTime.now());
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream2 = messDetails
        .getMessInfo(costTableName, monthlyCostTableName, cost, DateTime.now());
    Stream<QuerySnapshot> stream3 = addMeal.getMessMemberList();
    return StreamBuilder<CombinedData3>(
      stream: Rx.combineLatest3(stream1, stream2, stream3,
          (DocumentSnapshot<Map<String, dynamic>> snapshot1,
              DocumentSnapshot<Map<String, dynamic>> snapshot2,
              QuerySnapshot snapshot3) {
        return CombinedData3(
            snapshot1.data(), snapshot2.data(), snapshot3.docs);
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic>? totalMeal = snapshot.data?.data1;
          Map<String, dynamic>? totalCost = snapshot.data?.data1;
          List? member = snapshot.data?.data3;
          double mealCost;
          try {
            mealCost = member?[indexOfMember]['meal'] *
                (totalCost?[cost] / totalMeal?[meal]);
          } catch (e) {
            mealCost = 0.0;
          }
          return ListView(
            shrinkWrap: true,
            children: [
              createCardForMemberDetail('Balance',
                  doubleOutput(member?[indexOfMember]['diposit'] - mealCost)),
              createCardForMemberDetail(
                  'Deposit', doubleOutput(member?[indexOfMember]['diposit'])),
              createCardForMemberDetail(
                  'Meal', doubleOutput(member?[indexOfMember]['meal'])),
              createCardForMemberDetail('Meal cost', mealCost),
              createCardForMemberDetail(
                  'Shopping cost', doubleOutput(member?[indexOfMember]['cost']))
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  double doubleOutput(dynamic doubleNumber) {
    if (doubleNumber == null) {
      return 0.0;
    } else {
      try {
        return (doubleNumber * 100).roundToDouble() / 100;
      } catch (e) {
        return 0.0;
      }
    }
  }

  Card createCardForMemberDetail(String valueName, double valueToShow) {
    return Card(
      color: Colors.teal[300],
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .06,
          vertical: MediaQuery.of(context).size.height * 0.008),
      elevation: 6,
      child: ListTile(
        title: Text(valueName),
        trailing: Text('$valueToShow'),
      ),
    );
  }
}

class CombinedData3 {
  final Map<String, dynamic>? data1;
  final Map<String, dynamic>? data2;
  final List? data3;

  CombinedData3(this.data1, this.data2, this.data3);
}
