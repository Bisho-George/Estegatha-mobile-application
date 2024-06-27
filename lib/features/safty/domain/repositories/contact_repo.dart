import 'package:estegatha/core/domain/model/contact_model.dart';

abstract class ContactRepo{
  void addContact(ContactModel contactModel);
  Future<List<ContactModel>> fetchContacts();
}