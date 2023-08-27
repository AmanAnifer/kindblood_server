import 'package:get_it/get_it.dart';
import 'package:kindblood_server/src/features/contacts_service/domain/usecase/contact_filter_sql_function.dart';
import 'package:kindblood_server/src/features/contacts_service/domain/usecase/submit_contact.dart';
import 'package:kindblood_server/src/features/contacts_service/presentation/submit_contact_router.dart';
import 'package:sqlite3/sqlite3.dart';
import 'features/contacts_service/data/datasource/contact_datastore.dart';
import 'features/contacts_service/domain/repository/contact_repository.dart';
import 'features/contacts_service/data/repository/contact_repository_impl.dart';
import 'features/contacts_service/domain/usecase/get_contact.dart';
import 'features/contacts_service/presentation/get_contact_router.dart';
import 'core/utils/first_run_check.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data layer begin
  var db = sqlite3.open("./kindblood_server.db");
  sl.registerLazySingleton<Database>(
    () => db,
    dispose: (instance) {
      instance.dispose();
    },
  );

  sl.registerLazySingleton<FirstRunCheck>(
    () => FirstRunCheckSQLite(
      db: sl(),
    ),
  );
  sl.registerLazySingleton<SQLBusinessLogicFunctions>(
    () => SQLBusinessLogicFunctions(),
  );
  sl.registerLazySingleton<ContactDataStore>(
    () => SQLiteContactDataStore(
      contactFilterSQLUtils: sl(),
      db: sl(),
    ),
  );
  // Data layer end
  // Data <-> domain interface begin
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(
      contactDataStore: sl(),
    ),
  );
  // Data <-> domain interface end
  // Domain layer begin
  sl.registerLazySingleton<GetContactUseCase>(
    () => GetContactUseCase(
      contactRepository: sl(),
    ),
  );
  sl.registerLazySingleton<SubmitContactUseCase>(
    () => SubmitContactUseCase(
      contactRepository: sl(),
    ),
  );
  // Domain layer end
  // Presentation (endpoint service) layer begin
  sl.registerLazySingleton<SubmitContactService>(
    () => SubmitContactServiceImpl(
      submitContactUseCase: sl(),
    ),
  );
  sl.registerLazySingleton<GetContactService>(
    () => GetContactServiceImpl(
      getContactUseCase: sl(),
    ),
  );
  // Presentation (endpoint service) layer end
}
