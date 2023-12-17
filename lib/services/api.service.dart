import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:promeal/services/path.api.dart';

class APIRepo {
  Future<dynamic> login(Map formData) async {
    Dio dio = Dio();

    dio.options.validateStatus = (status) {
      return status == 409 || (status! >= 200 && status < 420);
    };

    String url = APIRoute.login;

    try {
      Response response = await dio.post(url, data: formData);

      log(response.toString());

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
    }
  }

  Future<dynamic> signup(Map formData) async {
    Dio dio = Dio();

    dio.options.validateStatus = (status) {
      return status == 409 || (status! >= 200 && status < 420);
    };

    String url = APIRoute.register;

    try {
      Response response = await dio.post(url, data: formData);

      log(response.toString());

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
    }
  }

  Future<dynamic> refresh(String token) async {
    Dio dio = Dio();

    dio.options.validateStatus = (status) {
      return status == 409 || (status! >= 200 && status < 420);
    };

    dio.options.headers['Authorization'] = 'Bearer $token';

    dio.options.receiveTimeout = const Duration(milliseconds: 5000); // Timeout value in milliseconds - 5seconsd

    String url = APIRoute.refresh;

    try {
      Response response = await dio.get(url);

      log(response.toString());

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
    }
  }


  Future<dynamic> accounts({String token = ""}) async {
    Dio dio = Dio();

    dio.options.validateStatus = (status) {
      return status == 409 || (status! >= 200 && status < 420);
    };

     dio.options.headers['Authorization'] = 'Bearer $token';

    String url = APIRoute.accounts;

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
    }
  }

  
  Future<dynamic> transfers({String token = ""}) async {
    Dio dio = Dio();

    dio.options.validateStatus = (status) {
      return status == 409 || (status! >= 200 && status < 420);
    };

     dio.options.headers['Authorization'] = 'Bearer $token';

    String url = APIRoute.transfers;

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
    }
  }
}



//   Future<Response> register(Map formData) async {
//     Dio dio = Dio();

//     dio.options.validateStatus = (status) {
//       return status == 409 || (status! >= 200 && status < 420);
//     };

//     String url = APIRoute.register;

//     try {
//       Response response = await dio.post(url, data: formData);

//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return response;
//       }
//     } catch (e) {
//       return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
//     }
//   }

//   Future<Response> updateAuthority(Map formData, String token, String userId) async {
//     Dio dio = Dio();

//     dio.options.validateStatus = (status) {
//       return status == 409 || (status! >= 200 && status < 420);
//     };

//     dio.options.headers['Authorization'] = 'Bearer $token';

//     String url = "${APIRoute.validation}?account_id=$userId";

//     try {
//       Response response = await dio.put(url, data: formData);

//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return response;
//       }
//     } catch (e) {
//       return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
//     }
//   }

//   Future<dynamic> update(File data, Map payload, String token) async {
//     Dio dio = Dio();

//     dio.options.validateStatus = (status) {
//       return status == 409 || (status! >= 200 && status < 420);
//     };
//     dio.options.headers['Authorization'] = 'Bearer $token';
//     String url = APIRoute.update;

//     try {
//       print("hello world ${payload['image']} ");

//       final formData = FormData.fromMap({
//         'name': payload['name'],
//         'email': payload['email'],
//         // 'image': await MultipartFile.fromFile('http://localhost:50684/734323ce-5bd6-4dca-9db8-342dbbf4d82f', filename: 'profile.jpg'),
//         'website': payload['website'],
//         // 'password': payload['password'],
//         // 'file': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
//         // 'files': [
//         //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
//         //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
//         // ]
//       });

//       //  final bytes = await data.readAsBytes();
//       //   final MultipartFile file = MultipartFile.fromBytes(bytes, filename: "picture");
//       //   MapEntry<String, MultipartFile> imageEntry = MapEntry("image", file);
//       //   formData.files.add(imageEntry);

//       // formData.files.add()

//       print("next");

//       // print(imageEntry);

//       // FormData formData = FormData.fromMap({'name': payload['name'], 'email': payload['email'], 'image': await MultipartFile.fromFile(payload['image']), 'website': payload['website'], 'password': payload['password']});

//       Response response = await dio.put(
//         url,
//         data: formData,
//         options: Options(headers: {
//           'Content-Type': 'multipart/form-data',
//           'Accept': 'application/json',
//         }),
//       );

//       print("xyz ${response.statusCode}");

//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return response;
//       }
//     } catch (e) {
//       return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
//     }
//   }

//   Future<dynamic> refresh(String token) async {
//     Dio dio = Dio();

//     dio.options.validateStatus = (status) {
//       return status == 409 || (status! >= 200 && status < 420);
//     };

//     dio.options.headers['Authorization'] = 'Bearer $token';

//     String url = APIRoute.refresh;

//     try {
//       Response response = await dio.get(url);

//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return response;
//       }
//     } catch (e) {
//       return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
//     }
//   }

//   Future<dynamic> readGameConfig(String key) async {
//     Dio dio = Dio();

//     dio.options.validateStatus = (status) {
//       return status == 409 || (status! >= 200 && status < 420);
//     };

//     dio.options.headers['Authorization'] = 'Bearer token';

//     String url = '${APIRoute.gameConfig}$key';

//     try {
//       Response response = await dio.get(url);

//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return response;
//       }
//     } catch (e) {
//       return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
//     }
//   }

//   Future<dynamic> getCallsPerDay(String token, {String userId= ''}) async {
//     Dio dio = Dio();

//     dio.options.validateStatus = (status) {
//       return status == 409 || (status! >= 200 && status < 420);
//     };

//     dio.options.headers['Authorization'] = 'Bearer $token';

//     String url = '${APIRoute.requestPerDay}/$userId';

//     try {
//       Response response = await dio.get(url);

//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return response;
//       }
//     } catch (e) {
//       return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
//     }
//   }


//     Future<Response> postCallsPerDay(Map formData, String token) async {
//         Dio dio = Dio();

//         dio.options.validateStatus = (status) {
//           return status == 409 || (status! >= 200 && status < 420);
//         };

        
//         dio.options.headers['Authorization'] = 'Bearer $token';

//         String url = '${APIRoute.requestPerDay}';

//         try {
//           Response response = await dio.post(url, data: formData);

//           if (response.statusCode == 200) {
//             return response;
//           } else {
//             return response;
//           }
//         } catch (e) {
//           return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
//         }
//   }

//   Future<Response> createGameConfig(Map formData, String key) async {
//     Dio dio = Dio();

//     dio.options.validateStatus = (status) {
//       return status == 409 || (status! >= 200 && status < 420);
//     };

//     dio.options.headers['Authorization'] = 'Bearer token';

//     String url = '${APIRoute.gameConfig}$key';

//     try {
//       Response response = await dio.post(url, data: formData);

//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return response;
//       }
//     } catch (e) {
//       return Response(statusCode: 500, statusMessage: 'An error occurred', requestOptions: RequestOptions(path: ""));
//     }
//   }
// }
