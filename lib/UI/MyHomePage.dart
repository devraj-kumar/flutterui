import 'dart:io';
import 'package:Gocomet/login_page.dart';
import 'package:flutter/material.dart';
import 'package:Gocomet/utils/constants.dart' as global;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InAppWebViewController webView;
  CookieManager _cookieManager = CookieManager.instance();

  @override
  void initState() {
    super.initState();
    print("hello");
    print(global.redirectUrl);
    _cookieManager.setCookie(
      url: "https://gocomet.com/",
      name: "user",
      value: global.token,
      domain: ".gocomet.com",
      isSecure: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          title: const Text('Gocomet'),
          
          
        ),
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
              child: InAppWebView(
            initialUrl: global.redirectUrl,
            
            
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
                useShouldOverrideUrlLoading: true
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onLoadStart: (InAppWebViewController controller, String url) {
              if (url == "https://gocomet.com/login"){
                Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
           _cookieManager.setCookie(
            url: "https://gocomet.com/",
             name: "user",
             value: "",
             domain: ".gocomet.com",
              isSecure: true,
               );
              }
            },
            onLoadStop: (InAppWebViewController controller, String url) async {
             
            },
            shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
            

              if (Platform.isAndroid || shouldOverrideUrlLoadingRequest.iosWKNavigationType == IOSWKNavigationType.LINK_ACTIVATED) {
                controller.loadUrl(url: shouldOverrideUrlLoadingRequest.url, headers: {
                  'My-Custom-Header': 'custom_value=564hgf34'
                });
                return ShouldOverrideUrlLoadingAction.CANCEL;
              }
              return ShouldOverrideUrlLoadingAction.ALLOW;
            },
            
          ))
        ])),
      ),
      
    );
  }
}