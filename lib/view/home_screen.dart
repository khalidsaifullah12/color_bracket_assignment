import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_bracket_assignment/view/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../http/employe_api.dart';

class HomeScreen extends StatelessWidget {
  var getemploye = GetEmploye();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "List Of Employee".text.uppercase.xl2.bold.make(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                  future: getemploye.getEmployeData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                    width: 100,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                          itemCount: 50,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailScreen(
                                            id: snapshot.data![index]["id"]
                                                .toString(),
                                            name: snapshot.data![index]['name']
                                                .toString(),
                                            company: snapshot.data![index]
                                                ['company'],
                                            company_logo: snapshot.data![index]
                                                    ['company_logo']
                                                .toString(),
                                            designation: snapshot.data![index]
                                                    ['designation']
                                                .toString())));
                              },
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  width: 70,
                                  height: 50,
                                  imageUrl: snapshot.data![index]
                                          ['company_logo']
                                      .toString(),
                                  placeholder: (context, url) =>
                                      const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ).card.roundedLg.make(),
                                title: Text(snapshot.data![index]['name']
                                        .toString())
                                    .text
                                    .bold
                                    .ellipsis
                                    .italic
                                    .xl
                                    .color(Vx.neutral800)
                                    .make(),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        "Designation : "
                                            .text
                                            .color(Vx.neutral800)
                                            .bold
                                            .make(),
                                        Expanded(
                                            child: snapshot.data![index]
                                                    ['designation']
                                                .toString()
                                                .text
                                                .bold
                                                .ellipsis
                                                .italic
                                                .color(Colors.deepOrangeAccent)
                                                .make()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        "Company : "
                                            .text
                                            .color(Vx.neutral800)
                                            .bold
                                            .make(),
                                        " ${snapshot.data![index]['company']}"
                                            .text
                                            .bold
                                            .ellipsis
                                            .italic
                                            .color(Colors.deepOrangeAccent)
                                            .make(),
                                      ],
                                    ),
                                  ],
                                ),
                              ).card.make(),
                            );
                          });
                    }
                  }),
            ),
          ],
        ).p12().scrollVertical(),
      ),
    );
  }
}
