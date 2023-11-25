import 'package:ccp_clean_architecture/core/data/network/api/api_client.dart';
import 'package:ccp_clean_architecture/core/res/api_res.dart';

class TestingRepo {
  Future getTesting() async {
    final response = await ApiClient.call(ApiRes.singleUser, RequestType.get);

    return response;
  }
}
