import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:places/core/api/dio_api.dart';
import 'package:places/core/api/dio_query_util.dart';
import 'package:places/features/add_place/data/api/image_picker_api.dart';
import 'package:places/features/add_place/domain/model/image_source.dart'
    as domain;
import 'package:places/features/add_place/domain/repository/photo_repository.dart';

final class PhotoDataRepository implements PhotoRepository {
  const PhotoDataRepository({
    required ImagePickerApi imagePickerApi,
    required DioApi apiUtil,
  })  : _imagePickerApi = imagePickerApi,
        _apiUtil = apiUtil;

  final ImagePickerApi _imagePickerApi;
  final DioApi _apiUtil;

  @override
  FutureOr<File?> pickImage({required domain.ImageSource source}) =>
      _imagePickerApi.pickImage(source: source);

  /// Если загружен один файл, то путь к нему содержится в заголовке "location".
  /// Если в запросе было больше одного файла, то ответ в виде списка путей к загруженным файлам в теле ответа.
  @override
  Future<List<String>> uploadImages(List<File> images) async {
    if (images.isEmpty) return [];

    final formData = FormData();
    for (final image in images) {
      final path = image.path;
      final name = basename(path);
      final imageAsMultipartFile = await MultipartFile.fromFile(
        path,
        filename: name,
        contentType: MediaType.parse(lookupMimeType(path)!),
      );
      formData.files.addAll([MapEntry('files', imageAsMultipartFile)]);
    }
    final response = await DioQueryUtil.handleQuery(
      _apiUtil,
      requestType: RequestType.post,
      uri: '/upload_file',
      data: formData,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      var data = response.headers['location'];
      if (data == null) {
        final result = jsonDecode(response.data!) as Map<String, dynamic>;
        final urls = result['urls'] as List<dynamic>;
        data = urls.map((e) => e.toString()).toList();
      }

      return data
          .map((urlPath) => join(_apiUtil.httpClient.options.baseUrl, urlPath))
          .toList();
    }

    return [];
  }
}
