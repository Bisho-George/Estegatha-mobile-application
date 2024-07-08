import 'package:dio/dio.dart';
import 'package:estegatha/core/data/api/dio_auth.dart';
import 'package:estegatha/core/domain/model/contact_model.dart';
import 'package:estegatha/features/safty/domain/repositories/contact_repo.dart';
import 'package:estegatha/constants.dart';

class ContactApi extends ContactRepo{
  @override
  Future<void> addContact(ContactModel contactModel) async {
    Dio dio = await DioAuth.getDio();
    await dio.post(baseUrl + addContactEndPoint, data: {
      contactNameKey : contactModel.name,
      contactPhoneKey : contactModel.phoneNumber
    });
  }

  @override
  Future<List<ContactModel>> fetchContacts() async{
    List<ContactModel> contacts = [];
    Dio dio = await DioAuth.getDio();
    Response response = await dio.get(baseUrl + fetchContactsEndPoint);
    for(var contactJson in response.data){
      contacts.add(ContactModel.fromJson(contactJson));
    }
    return contacts;
  }

  deleteContact(ContactModel contactModel) async{
    Dio dio = await DioAuth.getDio();
    await dio.delete(baseUrl + addContactEndPoint, queryParameters: {
      'contactId' : contactModel.id
    });
  }

}