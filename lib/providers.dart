import 'package:dio/dio.dart';
import 'package:estegatha/features/catalog/persentation/view-model/catalog_cubit.dart';
import 'package:estegatha/features/home/presentation/view_models/organization_member_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/current_organization_cubit.dart';
import 'package:estegatha/features/organization/presentation/view_model/user_organizations_cubit.dart';
import 'package:estegatha/features/safety/presentation/view_model/user_health_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/add_contact_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/fitness_connect_cubit.dart';
import 'package:estegatha/features/safty/presentation/view_models/location_feedback_cubit.dart';
import 'package:estegatha/features/sign-up/data/data_source/signup_data_source.dart';
import 'package:estegatha/features/sign-up/data/repos/signup_repo_imp.dart';
import 'package:estegatha/features/sign-up/domain/use_cases/sign_up_use_case.dart';
import 'package:estegatha/features/sign-up/presentation/view_models/sign_up_cubit.dart';
import 'package:estegatha/features/sos/presentation/view_models/cubit/cancel_sos_cubit.dart';
import 'package:estegatha/utils/services/api_service.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:provider/single_child_widget.dart';

import 'features/edit_account/presentation/view_models/edit_account_cubit.dart';
import 'features/edit_account/presentation/view_models/edit_password_cubit.dart';
import 'features/edit_account/presentation/view_models/edit_phone_cubit.dart';
import 'features/forget-password/presentation/veiw_models/forget-password/forget_password_cubit.dart';
import 'features/landing/presentation/view_model/permissions_cubit.dart';
import 'features/organization/presentation/view_model/organization_cubit.dart';
import 'features/safty/presentation/view_models/contact_cubit.dart';
import 'features/safty/presentation/view_models/fitness_data_cubit.dart';
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
  BlocProvider<CatalogCubit>(
    create: (context) => CatalogCubit(),
  ),
  BlocProvider<SignUpCubit>(
    create: (context) => SignUpCubit(SignupUseCase(SignupRepoImp(
        signupDataSource: SignupDataSourceImp(ApiService(Dio()))))),
  ),
  BlocProvider<OrganizationMemberHomeCubit>(
    create: (context) => OrganizationMemberHomeCubit(),
  ),
  BlocProvider<AddContactCubit>(
    create: (context) => AddContactCubit(),
  ),
  BlocProvider<CatalogCubit>(
    create: (context) => CatalogCubit(),
  ),
  BlocProvider<FitnessConnectCubit>(
    create: (context) => FitnessConnectCubit(),
  ),
  BlocProvider<FitnessDataCubit>(
    create: (context) => FitnessDataCubit(),
  ),
  BlocProvider<LocationFeedbackCubit>(
    create: (context) => LocationFeedbackCubit(),
  ),
  BlocProvider<CancelSosCubit>(
    create: (context) => CancelSosCubit(),
  ),
];
