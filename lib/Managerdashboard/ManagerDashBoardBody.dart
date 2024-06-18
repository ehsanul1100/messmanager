import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';
import 'package:messmanager/Mess/mess_information.dart';
import 'package:rxdart/rxdart.dart';

class ManagerDashboardBody extends StatefulWidget {
  const ManagerDashboardBody({super.key});

  @override
  State<ManagerDashboardBody> createState() => _ManagerDashboardBodyState();
}

class _ManagerDashboardBodyState extends State<ManagerDashboardBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: StyleOfBackground.backgroundColor),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                  child: creatFutureBuilderForMessName(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                  child: Center(
                    child: Text(DateFormat('yMMM').format(DateTime.now())),
                  ),
                ),
                SizedBox(
                  // shadowColor: Color.fromARGB(95, 0, 0, 0),
                  height: MediaQuery.of(context).size.height * .20,
                  width: MediaQuery.of(context).size.width,
                  // blur: 6,
                  // opacity: .2,
                  child: creatStreamBuilderForMess(
                      'Meal_Table',
                      'Monthly_meal_table',
                      'Meal',
                      'Cost_Table',
                      'Monthly_cost_table',
                      'Cost',
                      'Diposit_Table',
                      'Monthly_diposit_table',
                      'Diposit'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*.1,
                  child: Center(child: Text('My info')),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width,
                    child: creatStreamBuilderForMember(
                        'Meal_Table',
                        'Monthly_meal_table',
                        'Meal',
                        'Cost_Table',
                        'Monthly_cost_table',
                        'Cost',
                        'Mess_Member_table')),
              ],
            ),
          ),
        )
      ],
    );
  }

  StreamBuilder<CombinedData3> creatStreamBuilderForMember(
    String mealTableName,
    String monthlyMealTableName,
    String meal,
    String costTableName,
    String monthlyCostTableName,
    String cost,
    String messMemberTableName,
  ) {
    MessDtails messDtails = MessDtails();
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream1 = messDtails
        .getMessInfo(mealTableName, monthlyMealTableName, meal, DateTime.now());
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream2 = messDtails
        .getMessInfo(costTableName, monthlyCostTableName, cost, DateTime.now());
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream3 =
        messDtails.getMemberInfo(messMemberTableName);
    return StreamBuilder<CombinedData3>(
      stream: Rx.combineLatest3(stream1, stream2, stream3,
          (DocumentSnapshot<Map<String, dynamic>> snapshot1,
              DocumentSnapshot<Map<String, dynamic>> snapshot2,
              DocumentSnapshot<Map<String, dynamic>> snapshot3) {
        return CombinedData3(
            snapshot1.data(), snapshot2.data(), snapshot3.data());
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic>? totalMealData = snapshot.data?.data1;
          Map<String, dynamic>? totalCostData = snapshot.data?.data2;
          Map<String, dynamic>? memberData = snapshot.data?.data3;
          double mealCost;
          try {
            mealCost = memberData?['meal']*(totalCostData?[cost] / totalMealData?[meal]);
          } catch (e) {
            mealCost = 0.0;
          }
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisCount: 1),
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'My balance',doubleOutput(memberData?['diposit']- mealCost)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'My Deposit', doubleOutput(memberData?['diposit'])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'My meal', doubleOutput(memberData?['meal'])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'My meal cost',
                    doubleOutput(mealCost)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'Shopping cost', doubleOutput(memberData?['cost'])),
              )
            ],
          );
        } else {
          return GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisCount: 1),
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('My balance', doubleOutput(0.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('My Deposit', doubleOutput(0.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('My meal', doubleOutput(0.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('My meal cost', doubleOutput(0.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Shopping cost', doubleOutput(0.0)),
              )
            ],
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

  StreamBuilder<CombinedData3> creatStreamBuilderForMess(
    String mealTableName,
    String monthlyMealTableName,
    String meal,
    String costTableName,
    String monthlyCostTableName,
    String cost,
    String depositTableName,
    String monthlyDepositTableName,
    String deposit,
  ) {
    MessDtails messDtails = MessDtails();
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream1 = messDtails
        .getMessInfo(mealTableName, monthlyMealTableName, meal, DateTime.now());
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream2 = messDtails
        .getMessInfo(costTableName, monthlyCostTableName, cost, DateTime.now());
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream3 =
        messDtails.getMessInfo(
            depositTableName, monthlyDepositTableName, deposit, DateTime.now());

    return StreamBuilder<CombinedData3>(
      stream: Rx.combineLatest3(stream1, stream2, stream3,
          (DocumentSnapshot<Map<String, dynamic>> snapshot1,
              DocumentSnapshot<Map<String, dynamic>> snapshot2,
              DocumentSnapshot<Map<String, dynamic>> snapshot3) {
        return CombinedData3(
            snapshot1.data(), snapshot2.data(), snapshot3.data());
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic>? mealData = snapshot.data?.data1;
          Map<String, dynamic>? costData = snapshot.data?.data2;
          Map<String, dynamic>? depositData = snapshot.data?.data3;

          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisCount: 1),
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Meal Rate',
                    doubleOutput(costData?[cost] / mealData?[meal])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Balance',
                    doubleOutput(depositData?[deposit] - costData?[cost])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    creatContainer('Total meal', doubleOutput(mealData?[meal])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    creatContainer('Total cost', doubleOutput(costData?[cost])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'Total deposit', doubleOutput(depositData?[deposit])),
              )
            ],
          );
        } else {
          return GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisCount: 1),
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Meal Rate', doubleOutput(0.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Balance', doubleOutput(0.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Total meal', doubleOutput(0.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Total cost', doubleOutput(0.0)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Total deposit', doubleOutput(0.0)),
              )
            ],
          );
        }
      },
    );
  }

  FutureBuilder<DocumentSnapshot<Map<String,dynamic>>> creatFutureBuilderForMessName(){
    MessDtails messDtails = MessDtails();
    return FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(future: messDtails.messNameReturn(), builder: (context, snapshot) {
      if (snapshot.hasData) {
        Map<String,dynamic>? messData = snapshot.data?.data();
        return Center(
          child: Text(messData?['messName']),
        );
      } else {
        return const Center(child: Text('Mess Name'),);
      }
    },);
  }
}


class CombinedData3 {
  final Map<String, dynamic>? data1;
  final Map<String, dynamic>? data2;
  final Map<String, dynamic>? data3;

  CombinedData3(this.data1, this.data2, this.data3);
}
