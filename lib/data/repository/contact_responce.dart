import 'dart:developer';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsResponse{
  Future<List<Contact>> getContacts()async{
    List<Contact> contacts = [];
    var status = await Permission.contacts.status;
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      return contacts;
    }
    log('var status = await Permission.contacts.status:  ${status.isDenied}');

    return contacts;
  
  }
}