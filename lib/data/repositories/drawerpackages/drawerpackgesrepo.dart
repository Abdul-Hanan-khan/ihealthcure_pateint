// ignore_for_file: camel_case_types, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:tabib_al_bait/data/controller/drawerpackages.dart';
import 'package:tabib_al_bait/models/drawerpackages/drawerpackagesbody.dart';
import 'package:tabib_al_bait/models/drawerpackages/drawerpackagesresponse.dart';
import 'package:tabib_al_bait/utils/constants.dart';

class drawerpackaesrepo {
  getpatienthistory(drawerpackagesrequestbody body,
      {bool isSearch = false}) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.drawerpackages),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          if (isSearch) {
            List<Packagesresponse>? newList = [];
            Drawerpackagescontroller.i.data = [];
            Drawerpackagescontroller.i.dt = [];
          }
          List<Packagesresponse>? newList = [];
          Iterable lst = result['Data'];
          newList = lst.map((e) => Packagesresponse.fromJson(e)).toList();
          for (var element in newList) {
            Drawerpackagescontroller.i.dt.add(element);
          }
          Drawerpackagescontroller.i
              .updateresponsedata(Drawerpackagescontroller.i.dt);
          log(Drawerpackagescontroller.i.dt.length.toString());
          Drawerpackagescontroller.i.updateloader(false);
        } else {
          Drawerpackagescontroller.i.updateloader(false);
          log('message');
        }
      } else {
        Drawerpackagescontroller.i.updateloader(false);
        log(response.statusCode.toString());
      }
    } catch (e) {
      Drawerpackagescontroller.i.updateloader(false);
      log(e.toString());
    }
  }
}
