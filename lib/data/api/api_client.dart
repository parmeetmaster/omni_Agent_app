import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;
import 'package:six_cash/data/model/response/error_response.dart';
import 'package:six_cash/util/app_constants.dart';

class ApiClient extends GetxService {
   String appBaseUrl = AppConstants.BASE_URL ;
  final SharedPreferences sharedPreferences;
  final String noInternetMessage = 'Connection to API server failed due to internet connection';
    final int timeoutInSeconds = 30;

  String token;
  Map<String, String> _mainHeaders;

  ApiClient({@required this.appBaseUrl, @required this.sharedPreferences})
  {
    //token = sharedPreferences.getString(AppConstants.TOKEN);
    print(" token.............................................$token");

    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

   void updateHeader(String token, String zoneID) {
     _mainHeaders = {
       'Content-Type': 'application/json; charset=UTF-8',
       'Authorization': 'Bearer $token',
       //AppConstants.ZONE_ID: zoneID
     };
   }


  Future<Response> getData(
    String uri, {
    Map<String, dynamic> query,
    String contentType,
    Map<String, String> headers,
    Function(dynamic) decoder,
  }) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
      }
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      print('Server issue occur');
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }

  }

  Future<Response> postData(
      String uri, dynamic body, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode){
        print('====> GetX Base URL: $appBaseUrl');
        print('====> GetX Call: $uri');
        print('====> GetX Body: $body');
      }
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      print("++++++++++++>>>=====");
      Response response = handleResponse(_response);

      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
   Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, {Map<String, String> headers}) async {
     try {
       if(Foundation.kDebugMode) {
         print('====> API Call: $uri\nToken: $token');
         print('====> API Body: $body with ${multipartBody.length} image ');
       }
       Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
       _request.headers.addAll(headers ?? _mainHeaders);
       for(MultipartBody multipart in multipartBody) {
         if(multipart.file != null) {
           if(Foundation.kIsWeb) {
             Uint8List _list = await multipart.file.readAsBytes();
             Http.MultipartFile _part = Http.MultipartFile(
               multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
               filename: basename(multipart.file.path), contentType: MediaType('image', 'jpg'),
             );
             _request.files.add(_part);
           }else {
             File _file = File(multipart.file.path);
             _request.files.add(Http.MultipartFile(
               multipart.key, _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last,
             ));
           }
         }
       }
       _request.fields.addAll(body);
       Http.Response _response = await Http.Response.fromStream(await _request.send());
       Response response = handleResponse(_response);
       if(Foundation.kDebugMode) {
         print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
       }
       return response;
     } catch (e) {
       return Response(statusCode: 1, statusText: noInternetMessage);
     }
   }


   Future<Response> putData(
    String uri,
    dynamic body, {
    Map<String, dynamic> query,
    String contentType,
    Map<String, String> headers,
    Function(dynamic) decoder,
    Function(double) uploadProgress
  }) async {
    try {
      print('====> GetX Call: $uri');
      print('====> GetX Body: $body');
      Http.Response _response = await Http.put(
          Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;

    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
   Future<Response> putMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, {Map<String, String> headers}) async {
     try {
       if(Foundation.kDebugMode) {
         print('====> API Call: $uri\nToken: $token');
         print('====> API Body: $body');
       }
       Http.MultipartRequest _request = Http.MultipartRequest('PUT', Uri.parse(appBaseUrl+uri));
       _request.headers.addAll(headers ?? _mainHeaders);
       for(MultipartBody multipart in multipartBody) {
         if(multipart.file != null) {
           if(Foundation.kIsWeb) {
             Uint8List _list = await multipart.file.readAsBytes();
             Http.MultipartFile _part = Http.MultipartFile(
               multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
               filename: basename(multipart.file.path), contentType: MediaType('image', 'jpg'),
             );
             _request.files.add(_part);
           }else {
             File _file = File(multipart.file.path);
             _request.files.add(Http.MultipartFile(
               multipart.key, _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last,
             ));
           }
         }
       }
       _request.fields.addAll(body);
       Http.Response _response = await Http.Response.fromStream(await _request.send());
       Response response = handleResponse(_response);
       if(Foundation.kDebugMode) {
         print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
       }
       return response;
     } catch (e) {
       return Response(statusCode: 1, statusText: noInternetMessage);
     }
   }

//   Future<Response> deleteData(
//     String uri, {
//     Map<String, dynamic> query,
//     String contentType,
//     Map<String, String> headers,
//     Function(dynamic) decoder,
//   }) async {
//     try {
//       print('====> GetX Call: $uri');
//       Response response = await delete(
//         appBaseUrl + uri,
//         headers: headers ?? mainHeaders,
//         contentType: contentType,
//         query: query,
//         decoder: decoder,
//       );
//       response = handleResponse(response);
//       print('====> GetX Response: ${response.body}');
//       return response;
//     } catch (e) {
//       return Response(statusCode: 1, statusText: e.toString());
//     }
//   }

//   Response handleResponse(Response response) {
//     Response _response = response;
//     if (_response.hasError &&
//         _response.body != null &&
//         _response.body is! String) {
//       ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
//       _response = Response(
//           statusCode: _response.statusCode,
//           body: _response.body,
//           statusText: _errorResponse.errors[0].message);
//     } else if (_response.hasError && _response.body == null) {
//       _response = Response(
//           statusCode: 0,
//           statusText:
//               'Connection to API server failed due to internet connection');
//     }
//     return _response;
//   }

   Response handleResponse(Http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    }catch(e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(), headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    return _response;
  }
 }
class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}

/*

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:six_cash/data/model/response/address_model.dart';
import 'package:six_cash/data/model/response/error_response.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  String token;
  Map<String, String> _mainHeaders;

  ApiClient({@required this.appBaseUrl, @required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    debugPrint('Token: $token');
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    }catch(e) {}
    updateHeader(
      token, _addressModel == null ? null : _addressModel.zoneId.toString(),
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
    );
  }

  void updateHeader(String token, String zoneID, String languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      AppConstants.ZONE_ID: zoneID,
      AppConstants.LOCALIZATION_KEY: languageCode ?? AppConstants.languages[0].languageCode
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic> query, Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
      }
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
        print('====> API Body: $body');
      }
      Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
      _request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody) {
        if(multipart.file != null) {
          if(Foundation.kIsWeb) {
            Uint8List _list = await multipart.file.readAsBytes();
            Http.MultipartFile _part = Http.MultipartFile(
              multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
              filename: basename(multipart.file.path), contentType: MediaType('image', 'jpg'),
            );
            _request.files.add(_part);
          }else {
            File _file = File(multipart.file.path);
            _request.files.add(Http.MultipartFile(
              multipart.key, _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last,
            ));
          }
        }
      }
      _request.fields.addAll(body);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String> headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
      }
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if(Foundation.kDebugMode) {
        print('====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    }catch(e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(), headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.errors[0].message);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    return _response;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}*/
