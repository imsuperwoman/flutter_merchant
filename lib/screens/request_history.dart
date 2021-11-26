import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mse_customer/models/request_history/request_history.dart';
import 'package:mse_customer/models/request_history/request_history_data.dart';
import 'package:mse_customer/screens/request_history_detail.dart';
import 'package:mse_customer/screens/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RequestHistoryScreen extends StatefulWidget {
  @override
  _RequestHistoryScreenState createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  final formKey = GlobalKey<FormState>();
  int currentPage = 1;
  late int totalPages;
  List<RequestHistoryData> history = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getRequestHistoryData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    final String response =
        await rootBundle.loadString('assets/json/request_history.json');
    // if (response.statusCode == 200) {
    final result = requestHistoryFromJson(response);

    if (isRefresh) {
      history = result.data!.cast<RequestHistoryData>();
    } else {
      history.addAll(result.data!.cast<RequestHistoryData>());
    }

    currentPage++;

    totalPages = result.total!;

    setState(() {});
    return true;
  }

  // else {
  //   return false;
  // }
  //}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: <Widget>[
      backgroundImage(context),
      Scaffold(
        appBar: appBarColor("history_title".tr()),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            onRefresh: () async {
              final result = await getRequestHistoryData(isRefresh: true);
              if (result) {
                refreshController.refreshCompleted();
              } else {
                refreshController.refreshFailed();
              }
            },
            onLoading: () async {
              final result = await getRequestHistoryData();
              if (result) {
                refreshController.loadComplete();
              } else {
                refreshController.loadFailed();
              }
            },
            child: ListView.separated(
              itemBuilder: (context, index) {
                final histories = history[index];

                return ListTile(
                  contentPadding: EdgeInsets.all(0),
                  isThreeLine: true,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      labelUnBoldText(histories.date ?? ""),
                      labelText(histories.des ?? ""),
                      labelUnBoldText(histories.location ?? ""),
                      labelUnBoldText(histories.weight ?? ""),
                      labelUnBoldText(histories.status ?? ""),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 80,
                      minHeight: 80,
                      maxWidth: 80,
                      maxHeight: 80,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1/1,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.fill,
                          placeholder: noImage,
                          image: histories.imageUrl ?? "",
                          imageErrorBuilder: (context, error, stackTrace) {
                            return noImages();
                          },
                        ),
                    ),
                  ),
                  onTap: (){
                    print(histories.id);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RequestHistoryDetailScreen()),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.white),
              itemCount: history.length,
            ),
          ),
        ),
      ),
    ]));
  }
}
