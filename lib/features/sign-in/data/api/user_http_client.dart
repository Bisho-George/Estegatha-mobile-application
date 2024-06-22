import 'package:estegatha/utils/constant/variables.dart';
import 'package:estegatha/utils/helpers/helper_functions.dart';

import 'package:http/http.dart' as http;

class UserHttpClient {
  static String userBaseUrl = '${ConstantVariables.uri}/api/v1/users';

  // get user organizations
  static Future<http.Response> getUserOrganizations(int userId) async {
    final accessToken = await HelperFunctions.getAccessToken();
    print("Enter getUserOrganizations");
    final res = await http.get(
      Uri.parse('$userBaseUrl/organizations'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $accessToken"
      },
    );

    print("Response from getUserOrganizations: ${res.body}");

    return res;
  }
}
