import 'package:bulkwork/src/methods/full_gym_details.dart';
import 'package:bulkwork/src/models/full_gym.dart';
import 'package:bulkwork/src/pages/screens/dayManage.dart';
import 'package:bulkwork/src/widgets/muscle_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayRect extends StatefulWidget {
  final String week, day;
  const DayRect({super.key, required this.week, required this.day});

  @override
  State<DayRect> createState() => _DayRectState();
}

class _DayRectState extends State<DayRect> {
  late String? ex1, ex2, ex3, ex4, ex5;
  late FullGymDays? muscleObj;
  late bool? restDay;

  @override
  void initState() {
    super.initState();
    ex1 = "";
    ex2 = "";
    ex3 = "";
    ex4 = "";
    ex5 = "";
    restDay = false;
    getMuscle();
  }

  Future getMuscle() async {
    muscleObj = await FullGymExercise()
        .getMusclesDetails(week: widget.week, day: widget.day);

    setState(() {
      ex1 = muscleObj!.ex1;
      ex2 = muscleObj!.ex2;
      ex3 = muscleObj!.ex3;
      ex4 = muscleObj!.ex4;
      ex5 = muscleObj!.ex5;
      restDay = muscleObj!.restday!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: restDay == true
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                height: 220,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 65, 21, 225),
                      Color.fromARGB(255, 240, 54, 200)
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        widget.day,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 246, 245, 245),
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Rest Day",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 246, 245, 245),
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                height: 220,
                width: 340,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 19, 46, 145),
                      Color.fromARGB(255, 102, 4, 109),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.green,
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  child: Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 3,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 15, right: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => DayManager(
                                  fullGymDays: muscleObj!,
                                  day: widget.day,
                                  week: widget.week,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            widget.day,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      ex1 == null
                          ? Text("")
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MuscleBtn(muscle: ex1 ?? ""),
                            ),
                      ex2 == null
                          ? Text("")
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MuscleBtn(muscle: ex2 ?? ""),
                            ),
                      ex3 == null
                          ? Text("")
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MuscleBtn(muscle: ex3 ?? ""),
                            ),
                      ex4 == null
                          ? Text("")
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MuscleBtn(muscle: ex4 ?? ""),
                            ),
                      ex5 == null
                          ? Text("")
                          : Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: MuscleBtn(muscle: ex5 ?? ""),
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
