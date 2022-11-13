import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_bracket_assignment/view/web_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../http/detail_api.dart';

class DetailScreen extends StatefulWidget {
  String name, company, company_logo, designation, id;

  DetailScreen(
      {required this.id,
      required this.name,
      required this.company,
      required this.company_logo,
      required this.designation});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var detailApi = DetailApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray100,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details Of Employe ").text.bold.italic.make(),
      ),
      body: FutureBuilder(
          future: detailApi.getEmployeDetail(widget.id),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.company_logo.toString(),
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ).card.circular.make(),
                  ),
                  widget.company.text.bold.xl3.uppercase
                      .color(Colors.deepOrangeAccent)
                      .italic
                      .make(),
                  MyRow(title: "Name", value: widget.name),
                  MyRow(title: "Company", value: widget.company),
                  MyRow(title: "Designation", value: widget.designation),
                  MyRow(
                      title: "Rating",
                      value: snapshot.data![0]["rating"].toString()),
                  MyRow(
                      title: "Interests",
                      value: snapshot.data![0]["interests"].toString()),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Job Description :".text.bold.xl.italic.black.make(),
                        Text(snapshot.data![0]["job_descripton"].toString())
                            .text
                            .bold
                            .xl
                            .italic
                            .color(Colors.deepOrangeAccent)
                            .make(),
                      ],
                    ),
                  ).card.make(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return WebViewScreen(
                              url: snapshot.data![0]["view_more"].toString());
                        }));
                      },
                      child: "View More...".text.bold.black.make())
                ],
              ).p4().scrollVertical();
            }
          }),
    );
  }
}

class MyRow extends StatelessWidget {
  String title, value;
  MyRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(title).text.bold.italic.xl.make(),
              const Spacer(),
              Text(value)
                  .text
                  .bold
                  .color(Colors.deepOrangeAccent)
                  .italic
                  .xl
                  .make(),
            ],
          ),
        ).card.make(),
        const Divider(),
      ],
    );
  }
}
