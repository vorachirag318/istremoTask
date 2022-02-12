import 'package:demotask/core/constant/app_color.dart';
import 'package:demotask/core/utils/config.dart';
import 'package:demotask/ui/home_screen/controller/home_controller.dart';
import 'package:demotask/ui/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonListWidget extends StatelessWidget {
  const CommonListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController homeController) => RefreshIndicator(
        onRefresh: () async {
          await homeController.refreshList();
        },
        child: ListView(
          controller: homeController.scrollController,
          children: homeController.allData
              .asMap()
              .map((index, data) => MapEntry(
                  index,
                  Column(
                    children: [
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColor.kPrimaryFontColor
                                        .withOpacity(0.20)))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Icon(
                                Icons.book_sharp,
                                size: getWidth(40),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.name),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    data.description,
                                    style: TextStyle(
                                        color: AppColor.kPrimaryFontColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      iconAndText(
                                          iconData: Icons.code,
                                          text: data.language),
                                      iconAndText(
                                          iconData: Icons.bug_report,
                                          text: data.stargazersCount),
                                      iconAndText(
                                          iconData: Icons.face,
                                          text: data.watchersCount),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: (index + 1) == homeController.allData.length
                            ? homeController.hasNext
                                ? getLoader()
                                : const SizedBox()
                            : const SizedBox(),
                      )
                    ],
                  )))
              .values
              .toList(),
        ),
      ),
    );
  }

  iconAndText({required IconData iconData, dynamic text}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(
            width: 3,
          ),
          Text(
            "$text",
            style: TextStyle(color: AppColor.kPrimaryFontColor),
          )
        ],
      ),
    );
  }
}
