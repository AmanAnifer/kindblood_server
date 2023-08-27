import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:kindblood_common/core_entities.dart';
import 'package:kindblood_server/src/core/status_objects/failure.dart';
import 'package:kindblood_server/src/core/status_objects/success.dart';
import '../repository/contact_repository.dart';

class SubmitContactUseCase {
  final ContactRepository contactRepository;
  SubmitContactUseCase({required this.contactRepository});

  Future<Either<Failure, Success>> submitContact(
      {required String submittedContactJsonString}) async {
    var thing = jsonDecode(
      submittedContactJsonString,
    );
    print(thing.runtimeType);
    final MyInfo submittedContact =
        MyInfo.fromJson(thing as Map<String, dynamic>);
    var response =
        contactRepository.submitContact(submittedContact: submittedContact);
    return response;
  }
}
