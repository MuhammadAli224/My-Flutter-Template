import 'package:dio/dio.dart';

import '../../../../../core/errors/dio_exception.dart';
import '../../../../../core/model/api_response.dart';
import '../../../../../core/services/api.service.dart';
import '../../endpoint/{{name.snakeCase()}}_endpoint.dart';
import '../../model/{{name.snakeCase()}}_dto.dart';

abstract interface class {{name.pascalCase()}}RemoteDataSource {
  Future<List<{{name.pascalCase()}}DTO>> fetchAll({CancelToken? cancelToken});
}

class {{name.pascalCase()}}RemoteDataSourceImpl
    implements {{name.pascalCase()}}RemoteDataSource {
  {{name.pascalCase()}}RemoteDataSourceImpl(this._api);

  final ApiServices _api;

  @override
  Future<List<{{name.pascalCase()}}DTO>> fetchAll({CancelToken? cancelToken}) async {
    final json = await _api.getData(
      {{name.pascalCase()}}Endpoint.get{{name.pascalCase()}},
      cancelToken: cancelToken,
    );
    final response = ApiResponse<{{name.pascalCase()}}DTO>.fromJson(
      json,
      (value) => {{name.pascalCase()}}DTO.fromJson(value as Map<String, dynamic>),
    );
    if (response.hasError) {
      throw AppException.fromResponse(Response<dynamic>(
        requestOptions: RequestOptions(),
        statusCode: response.code,
        data: {'message': response.description, 'error': response.error},
      ));
    }
    // Missing/malformed data is not an empty successful response.
    if (response.list == null) {
      throw const FormatException('Expected a list in the data field');
    }
    return response.list!;
  }
}
