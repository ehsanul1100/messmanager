
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messmanager/LoginPage/textfildStyle.dart';
import 'package:messmanager/Managerdashboard/ManagerDashboardDesign.dart';

class ManagerDashboardBody extends StatefulWidget {
  const ManagerDashboardBody({super.key});

  @override
  State<ManagerDashboardBody> createState() => _ManagerDashboardBodyState();
}

class _ManagerDashboardBodyState extends State<ManagerDashboardBody> {
  
  double? myMeal = 0.0;
  double? myDeposit = 0.0;
  double? myCost = 0.0;
  double? myBalance = 0.0;
  double? mealRate = 0.0;
  double? balance = 0.0;
  double? totalMeal = 0.0;
  double? totalDeposit = 0.0;
  double? totaShoppingCost = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: linearGradient),
        ),
        Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //       color: Color.fromARGB(255, 55, 118, 150),
                //       borderRadius: BorderRadius.only(
                //           bottomLeft: Radius.circular(10),
                //           bottomRight: Radius.circular(10)),
                //       boxShadow: [boxShadow]),
                //   height: MediaQuery.of(context).size.height * .01,
                //   width: MediaQuery.of(context).size.width,
                // ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        boxShadow
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    // shadowColor: Color.fromARGB(95, 0, 0, 0),
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width * .92,
                    // blur: 6,
                    // opacity: .2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 2,
                              child: creatContainer('Meal Rate', mealRate)),
                          Expanded(
                              flex: 2, child: creatContainer('Balance', balance)),
                          Expanded(
                              flex: 2,
                              child: creatContainer('Total Meal', totalMeal)),
                          Expanded(
                              flex: 2,
                              child: creatContainer('Total Diposit', totalDeposit)),
                          Expanded(
                              flex: 2,
                              child: creatContainer(
                                  'Total Shopping Cost', totaShoppingCost)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    // opacity: .2,
                    // blur: 6,
                    // shadowStrength: 4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        boxShadow
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width * .92,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide())
                              ),
                              child: Text('My Info'),
                            ),
                          ),
                          Expanded(
                                flex: 2,
                                child: creatContainer('Meal', myMeal)),
                            Expanded(
                                flex: 2, child: creatContainer('Diposit', myDeposit)),
                            Expanded(
                                flex: 2,
                                child: creatContainer('Cost', myCost)),
                            Expanded(
                                flex: 2,
                                child: creatContainer('Balance', myBalance)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        boxShadow
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: MediaQuery.of(context).size.width * .92,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Bazar Date'),
                        Text('Date')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
