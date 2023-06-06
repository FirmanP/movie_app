import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/io_client.dart' as ioc;
import 'package:http/http.dart' as http;


final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class SSLHttp {
  Future<http.Response> ioClientGet(String url) async {
    final sslCert = await rootBundle.load('assets/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    ioc.IOClient ioClient = ioc.IOClient(client);
    return await ioClient.get(Uri.parse(url));
    // return securityContext;
  }

  // Future get getCertificate async {

  // return client;
  // return ioc.IOClient(client);
}

  // Future<http.Response> ioClientGet(String url) async {
   
  // }
  
// }
 