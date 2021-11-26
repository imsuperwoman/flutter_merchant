import 'package:image_picker/image_picker.dart';

class User {
  int? userId;
  String? name;
  String? email;
  String? point;
  String? contactNumber;
  String? username;
  String? address;
  String? identity;
  String? type;
  String? companyName;
  String? companyAddress;
  String? companySsmNumber;
  String? companyContact;
  String? personInCharge;
  String? accountBankNo;
  String? bankName;
  String? token;
  bool notification;
  String? password;
  XFile? image;

  User(
      {this.userId,
         this.name,
         this.email,
        this.point,
         this.contactNumber,
        this.username,
        this.address,
        this.identity,
         this.type,
        this.companyName,
        this.companyAddress,
        this.companySsmNumber,
        this.companyContact,
        this.personInCharge,
        this.accountBankNo,
        this.bankName,
        this.token,
        this.password,
        this.notification = false,

      });

  // now create converter

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['customer']['id'],
      name: responseData['customer']['name'],
      email: responseData['customer']['email'],
      point: responseData['customer']['point'],
      contactNumber: responseData['customer']['contact_number'],
      username: responseData['customer']['username'],
      address: responseData['customer']['address'],
      identity: responseData['customer']['nric'],
      type: responseData['customer']['type'],
      companyName: responseData['customer']['company_name'],
      companyAddress: responseData['customer']['company_address'],
      companySsmNumber: responseData['customer']['company_ssm_number'],
      companyContact: responseData['customer']['company_contact'],
      accountBankNo: responseData['customer']['account_bank_no'],
      bankName: responseData['customer']['bank_name'],
      token: responseData['token'],
    );
  }
}
