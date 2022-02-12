import 'package:demotask/core/local_db/moor_db.dart';
import 'package:demotask/core/service/repo/gitdata_repo.dart';
import 'package:demotask/ui/home_screen/model/git_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class HomeController extends GetxController {
  final moorDb = GetIt.I.get<MoorDbClient>();

  int page = 1;
  int lastFetchLength = 0;

  List<GitDummyDataModel> allData = [];

  bool _hasNext = true;
  bool get hasNext => _hasNext;

  bool isFetching = false;

  bool fullScreenLoader = true;

  Future fetchGitData() async {
    if (isFetching) {
      return;
    }
    if (!hasNext) {
      return;
    }
    isFetching = true;

    if (page == 1) {
      allData.clear();
    }
    final request = await GitDataRepo.getGitData(page: page);

    if (request != null) {
      print("data from api");

      List<GitDummyDataModel> dataList = List<GitDummyDataModel>.from(
          request.map((e) => GitDummyDataModel.fromJson(e)));
      moorDb.insert(dataList);

      allData.addAll(dataList);
      if (dataList.length < 15) {
        _hasNext = false;
      } else {
        page++;
        isFetching = false;
      }
    }
    if (request == null) {
      print("data from db");
      final v = await moorDb.getNotificationData();
      isFetching = false;

      if (v.isNotEmpty) {
        allData.clear();
        allData.addAll(v.map((e) => GitDummyDataModel.fromEntity(e)));
        _hasNext = false;
      }
    }
    fullScreenLoader = false;
    update();
  }

  final scrollController = ScrollController();

  Future refreshList({bool? isLoader}) async {
    if (isLoader ?? false) {
      fullScreenLoader = true;
      update();
    }
    page = 1;
    await fetchGitData();
    _hasNext = true;
  }

  @override
  void onInit() {
    fetchGitData();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent / 2 &&
          !scrollController.position.outOfRange) {
        fetchGitData();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
