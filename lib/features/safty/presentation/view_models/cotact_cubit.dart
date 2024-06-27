import 'package:estegatha/core/domain/model/contact_model.dart';
import 'package:estegatha/features/safty/data/api/contact_api.dart';
import 'package:estegatha/features/safty/presentation/view_models/cotact_state.dart';
import 'package:bloc/bloc.dart';
class ContactCubit extends Cubit<ContactState>{
  ContactCubit():super(ContactInitialState());
  List<ContactModel> contacts = [];
  bool isLoading = false;
  Future<void> addContact(ContactModel contactModel) async {
    isLoading = true;
    ContactApi contactApi = ContactApi();
    try{
      await contactApi.addContact(contactModel);
      contacts.add(contactModel);
      emit(ContactSuccessState());
    }catch(e){
      emit(ContactFailureState('add contact failed'));
    }
    isLoading = false;
  }
  Future<void> fetchContact() async {
    isLoading = true;
    ContactApi contactApi = ContactApi();
    try{
      contacts = await contactApi.fetchContacts();
      emit(ContactSuccessState());
    }catch(e){
      emit(ContactFailureState('fetch contact failed'));
    }
    isLoading = false;
  }
}