import 'package:estegatha/core/domain/model/contact_model.dart';
import 'package:estegatha/features/safty/data/api/contact_api.dart';
import 'package:estegatha/features/safty/domain/repositories/contact_repo.dart';
import 'package:estegatha/features/safty/presentation/view_models/contact_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactState> {

  AddContactCubit() : super(AddContactState());

  bool isloding = false;
  Future<void> addContact(ContactModel contact) async {
    isloding = true;
    ContactRepo contactRepo = ContactApi();
    try {
      await contactRepo.addContact(contact);
      emit(AddContactSuccess(contact));
    } catch (e) {
      emit(AddContactFailure(e.toString()));
    }
    isloding = false;
  }
}