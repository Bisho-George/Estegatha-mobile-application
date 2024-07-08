import 'package:estegatha/core/domain/model/contact_model.dart';
import 'package:estegatha/features/safty/data/api/contact_api.dart';
import 'package:estegatha/features/safty/presentation/view_models/contact_state.dart';
import 'package:bloc/bloc.dart';

import '../../../../constants.dart';
class ContactCubit extends Cubit<ContactState>{
  ContactCubit():super(ContactInitialState());
  List<ContactModel> contacts = [];
  bool isLoading = false;
  addContact(ContactModel contactModel) {
    contacts.add(contactModel);
    emit(ContactSuccessState('add contact success'));
  }
  Future<void> fetchContact() async {
    isLoading = true;
    ContactApi contactApi = ContactApi();
    try{
      contacts = await contactApi.fetchContacts().timeout(Duration(seconds: durationTimeout));
      emit(ContactSuccessState('fetch contact success'));
    }catch(e){
      emit(ContactFailureState('fetch contact failed'));
    }
    isLoading = false;
  }
  Future<void> deleteContact(ContactModel contactModel) async {
    isLoading = true;
    ContactApi contactApi = ContactApi();
    try{
      await contactApi.deleteContact(contactModel).timeout(Duration(seconds: durationTimeout));
      contacts.removeWhere((element) => element.id == contactModel.id);
      emit(ContactSuccessState('delete contact success'));
    }catch(e){
      emit(ContactFailureState('delete contact failed'));
    }
    isLoading = false;
  }
}