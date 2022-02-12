import 'dart:convert';
import 'dart:math';

import 'package:demotask/core/utils/app_functions.dart';
import 'package:demotask/ui/shared/loader.dart';

import 'package:http/http.dart' as http;

enum RequestApiType { get, post, put, delete }

class API {
  static late http.Response response;

  static Future apiHandler({
    required String url,
    RequestApiType requestType = RequestApiType.post,
    Map<String, String>? header,
    bool showLoader = true,
    bool showToast = true,
    dynamic body,
  }) async {
    try {
      if (await checkConnection()) {
        if (showLoader) LoadingOverlay.of().show();
        if (requestType == RequestApiType.get) {
          response = await http.get(
            Uri.parse(url),
            headers: header,
          );
        } else if (requestType == RequestApiType.post) {
          response =
              await http.post(Uri.parse(url), headers: header, body: body);
        } else if (requestType == RequestApiType.delete) {
          response = await http.delete(Uri.parse(url), headers: header);
        } else if (requestType == RequestApiType.put) {
          response =
              await http.put(Uri.parse(url), headers: header, body: body);
        }
        var responseDecode = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (showLoader) LoadingOverlay.of().hide();
          return responseDecode;
        } else {
          if (showLoader) LoadingOverlay.of().hide();
          return null;
        }
      } else {
        flutterToast("Connect internet to get updated record");
        return null;
      }
    } catch (e) {
      //print("ERROR FROM API CLASS $e");
    }
  }
}
