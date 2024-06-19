import 'package:carousel_slider/carousel_slider.dart';
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
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  // blur: 6,
                  // opacity: .2,
                  child: createStreamBuilderForMess(
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
                Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width,
                    child: createStreamBuilderForMember(
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

  StreamBuilder<CombinedData3> createStreamBuilderForMember(
    String mealTableName,
    String monthlyMealTableName,
    String meal,
    String costTableName,
    String monthlyCostTableName,
    String cost,
    String messMemberTableName,
  ) {
    MessDetails messDtails = MessDetails();
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
          return CarouselSlider(
            items: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'My balance',doubleOutput(memberData?['diposit']- mealCost),context
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'My Deposit', doubleOutput(memberData?['diposit']),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'My meal', doubleOutput(memberData?['meal']),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'My meal cost',
                    doubleOutput(mealCost),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'Shopping cost', doubleOutput(memberData?['cost']),context),
              )
            ],
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              pageSnapping: true,
              viewportFraction: .6,
            ),
          );
        } else {
          return CarouselSlider(
            items: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('My balance', doubleOutput(0.0),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('My Deposit', doubleOutput(0.0),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('My meal', doubleOutput(0.0),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('My meal cost', doubleOutput(0.0),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Shopping cost', doubleOutput(0.0),context),
              )
            ],
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              pageSnapping: true,
              viewportFraction: .6,
            ),
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

  StreamBuilder<CombinedData3> createStreamBuilderForMess(
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
    MessDetails messDetails = MessDetails();
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream1 = messDetails
        .getMessInfo(mealTableName, monthlyMealTableName, meal, DateTime.now());
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream2 = messDetails
        .getMessInfo(costTableName, monthlyCostTableName, cost, DateTime.now());
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream3 =
        messDetails.getMessInfo(
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

          return CarouselSlider(
            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     mainAxisSpacing: 10, crossAxisCount: 1),
            // scrollDirection: Axis.horizontal,
            items: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Meal Rate',
                    doubleOutput(costData?[cost] / mealData?[meal]),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Balance',
                    doubleOutput(depositData?[deposit] - costData?[cost]),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    creatContainer('Total meal', doubleOutput(mealData?[meal]),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    creatContainer('Total cost', doubleOutput(costData?[cost]),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer(
                    'Total deposit', doubleOutput(depositData?[deposit]),context),
              )
            ],
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              pageSnapping: true,
              enableInfiniteScroll: false,
              viewportFraction: .6,
            ),
          );
        } else {
          return CarouselSlider(
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     mainAxisSpacing: 10, crossAxisCount: 1),
            // scrollDirection: Axis.horizontal,
            items: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Meal Rate', doubleOutput(0.0),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Balance', doubleOutput(0.0),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Total meal', doubleOutput(0.0),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Total cost', doubleOutput(0.0),context),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: creatContainer('Total deposit', doubleOutput(0.0),context),
              )
            ],
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              pageSnapping: true,
              viewportFraction: .6,
            ),
          );
        }
      },
    );
  }

  FutureBuilder<DocumentSnapshot<Map<String,dynamic>>> creatFutureBuilderForMessName(){
    MessDetails messDtails = MessDetails();
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
