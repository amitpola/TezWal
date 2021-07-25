import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'wallet.g.dart';

@HiveType(typeId: 0)
class Wallet{
  @HiveField(0)
  List<String> mnemonic;
  @HiveField(1)
  String secret;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String pkh;
  @HiveField(4)
  String password;
  @HiveField(5)
  String email;

  Wallet({@required this.email,@required this.password,@required this.amount,@required this.mnemonic,@required this.pkh,@required this.secret});

  Wallet.fromJson(Map<String ,dynamic> json){
    mnemonic=json['mnemonic'].cast<String>();
    secret=json['secret'];
    amount=json['amount'];
    pkh=json['pkh'];
    password=json['password'];
    email=json['email'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['mnemonic']=this.mnemonic;
    data['amount']=this.amount;
    data['pkh']=this.pkh;
    data['password']=this.password;
    data['email']=this.email;
    data['secret']=this.secret;
    return data;
  }

}