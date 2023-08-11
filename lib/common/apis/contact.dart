import 'package:chatter/common/entities/entities.dart';
import 'package:chatter/common/utils/utils.dart';

class ContactAPI {

  /// refresh
  static Future<ContactResponseEntity> post_contact() async {
    var response = await HttpUtil().post(
      'api/contact',
    );
    return ContactResponseEntity.fromJson(response);
  }


}
