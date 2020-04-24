import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Providers/App_Provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DownloadAlert extends StatefulWidget {
  final String url;
  final String path;

  DownloadAlert({
    Key key,
    @required this.url,
    @required this.path
  }):super(key: key);

  @override
  _DownloadAlertState createState() => _DownloadAlertState();
}


class _DownloadAlertState extends State<DownloadAlert> {
  

  Dio dio = new Dio();
  int received = 0;
  String progress = "0";
  int total = 0;

  download() async{
    await dio.download(widget.url,widget.path,
      deleteOnError: true,
      onReceiveProgress: (receivedBytes, totalBytes) {
        setState (() {
          received = receivedBytes;
          total = totalBytes;
          progress = (received / total * 100).toStringAsFixed(0);
        }
        );
        //Check if download is complete and close the alert dialog
        if(receivedBytes == totalBytes){
          Navigator.pop(context, "${AppProvider.formatBytes(total, 1)}");
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left:20, right: 20, top: 100, bottom: 300),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
            child: Padding(padding: EdgeInsets.all(30),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SpinKitChasingDots(color: Color(0xff6e9bdf)),
                  SizedBox(
                    height: 10,
                  ),
                Text(
                "Downloading",
                style: TextStyle(
                  color: Color(0xff6e9bdf),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: LinearProgressIndicator(
                  value: double.parse(progress)/100,
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  backgroundColor: Theme.of(context).accentColor.withOpacity(0.3),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "$progress %",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    "${AppProvider.formatBytes(received, 1)} "
                        "of ${AppProvider.formatBytes(total, 1)}",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}
