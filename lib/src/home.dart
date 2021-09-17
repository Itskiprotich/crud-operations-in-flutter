import 'package:crud/src/models/user.dart';
import 'package:crud/src/network/api.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends StatefulWidget {
  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<Home> {
  List<UserData> data = [];

  bool isLoading = false;
  bool isLastPage = false;

  bool load = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Crud Operations'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Notification',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Coming soon')));
            },
          ),
          ],
      ),
      body: Container(
        child: NotificationListener(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollEndNotification) {
              if (!isLastPage &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                page++;
                load = true;
                isLoading = true;
                setState(() {});
              }
            }
            return isLastPage;
          },
          child: FutureBuilder<AppListingModel>(
            future: getUserList(page),
            builder: (_, snap) {
              if (snap.hasData) {
                isLastPage = snap.data!.data.length != 6;

                if (page == 1) data.clear();
                if (page == snap.data!.page) {
                  data.addAll(snap.data!.data);
                  load = false;
                }

                return Column(
                  children: [
                    ListView.builder(
                      itemCount: data.length,
                      padding: EdgeInsets.all(8),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var getListData = data[index];

                        return Container(
                          padding: EdgeInsets.all(8),
                          decoration: boxDecorationWithRoundedCorners(
                              boxShadow: defaultBoxShadow(),
                              backgroundColor: Colors.amberAccent),
                          margin: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: boxDecorationWithShadow(
                                  decorationImage: DecorationImage(
                                      image: Image.network(
                                              getListData.avatar.validate())
                                          .image,
                                      fit: BoxFit.cover),
                                  boxShape: BoxShape.circle,
                                ),
                              ),
                              16.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(getListData.email.validate(),
                                      style: boldTextStyle(size: 16)),
                                  8.height,
                                  Text(getListData.firstName.validate(),
                                      style: primaryTextStyle(size: 14)),
                                  8.height,
                                  Text(getListData.lastName.validate(),
                                      style: secondaryTextStyle(size: 12)),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ).expand(),
                    Loader().visible(load)
                  ],
                );
              }
              return snapWidgetHelper(snap);
            },
          ),
        ),
      ),
    );
  }
}
