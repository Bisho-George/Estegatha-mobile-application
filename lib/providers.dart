import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/user_organizations_cubit.dart';
import 'package:estegatha/features/safety/presentation/view_model/user_health_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/add_contact_cubit.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:provider/single_child_widget.dart';

import 'features/edit_account/presentation/view_models/edit_account_cubit.dart';
import 'features/edit_account/presentation/view_models/edit_password_cubit.dart';
import 'features/edit_account/presentation/view_models/edit_phone_cubit.dart';
import 'features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'features/landing/presentation/view_model/permissions_cubit.dart';
import 'features/organization/presentation/view_model/organization_cubit.dart';
import 'features/safty/presentation/view_models/contact_cubit.dart';
import 'features/sign-in/presentation/veiw_models/login_cubit/login_cubit.dart';
import 'features/sign-in/presentation/veiw_models/user_cubit.dart';
import 'features/sos/presentation/view_models/cubit/create_pin_cubit.dart';
import 'features/sos/presentation/view_models/cubit/send_sos_cubit.dart';

List<SingleChildWidget> providers = [
  BlocProvider<UserCubit>(
    create: (context) => UserCubit(),
  ),
  BlocProvider<LoginCubit>(
    create: (context) => LoginCubit(),
  ),
  BlocProvider<ForgetPasswordCubit>(
    create: (context) => ForgetPasswordCubit(),
  ),
  BlocProvider<OrganizationCubit>(
    create: (context) => OrganizationCubit(),
  ),
  BlocProvider<PermissionCubit>(
    create: (context) => PermissionCubit(),
  ),
  BlocProvider<CreatePinCubit>(
    create: (context) => CreatePinCubit(),
  ),
  BlocProvider<SendSosCubit>(
    create: (context) => SendSosCubit(),
  ),
  BlocProvider<ContactCubit>(
    create: (context) => ContactCubit(),
  ),
  BlocProvider<EditAccountCubit>(
    create: (context) => EditAccountCubit(),
  ),
  BlocProvider<EditPhoneCubit>(
    create: (context) => EditPhoneCubit(),
  ),
  BlocProvider<EditPasswordCubit>(
    create: (context) => EditPasswordCubit(),
  ),
  BlocProvider<UserOrganizationsCubit>(
    create: (context) => UserOrganizationsCubit(),
  ),
  BlocProvider<CurrentOrganizationCubit>(
    create: (_) => CurrentOrganizationCubit()..loadCurrentOrganization(),
  ),
  BlocProvider<UserHealthCubit>(
    create: (context) => UserHealthCubit(),
  ),
  BlocProvider<AddContactCubit>(
    create: (context) => AddContactCubit(),
  ),
];
