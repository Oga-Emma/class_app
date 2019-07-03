import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:flutter/material.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Today", textAlign: TextAlign.center),
          elevation: 0.0),
      body: Container(
          color: Colors.grey[200],
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      height: 55,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  Container(height: 30, color: Theme.of(context).primaryColor),
                  Container(
                    height: 55,
                    margin: EdgeInsets.symmetric(horizontal: 14.0),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 5),
                          color: Colors.grey,
                          blurRadius: 20,
                          spreadRadius: 1)
                    ], color: Colors.white, borderRadius: borderRadius),
                    child: /*ListView(
                        scrollDirection: Axis.horizontal,
                        children: getButtons(),
                      )*/

                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // This next line does the trick.
                      children: getButtons(),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Material(
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: borderRadius),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: borderRadius),
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("EXAMS",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white)),
                                    ),
                                    SizedBox(height: 10),
                                    Expanded(
                                      child: Text(
                                        'Update on CS8214 - Postponed to next week due to unforseen circumstances.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                              '10:40 AM',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            )),
                                        Icon(
                                          Icons.message,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '10',
                                          style: TextStyle(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        );
                      }))
            ],
          )),
    );
  }

  List<String> categories = [
    'Classes',
    'Others'
  ];
  int selected = 0;

  List<Widget> getButtons() {
    List<Widget> list = [];
    for (var i = 0; i < categories.length; i++) {
      if (i == selected) {
        list.add(getButton(i, categories[i], true));
      } else {
        list.add(getButton(i, categories[i], false));
      }
    }
    /*var list = categories.map((title) => getButton(title, false)).toList();
    list[selected] = getButton(categories[selected], true);*/
    return list;
  }

  Widget getButton(int index, title, bool clicked) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () {
            setState(() {
              selected = index;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.subtitle),
              SizedBox(height: 5.0),
              Container(
                color: clicked ? Colors.black45 : Colors.transparent,
                height: 2,
                width: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
