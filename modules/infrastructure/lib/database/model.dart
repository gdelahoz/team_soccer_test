import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';

const tablePerson = SqfEntityTable(
    tableName: 'person',
    primaryKeyName: 'uid',
    primaryKeyType: PrimaryKeyType.text,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('lastName', DbType.text),
      SqfEntityField('email', DbType.text),
      SqfEntityField('cellphone', DbType.text),
      SqfEntityField('photoUrl', DbType.text),
      SqfEntityField('dateOfBirth', DbType.datetime),
      SqfEntityField('dataPlayer', DbType.text),
      SqfEntityField('physicalinfo', DbType.text),
    ]);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'TeamSoccerDB',
  databaseName: 'teamsoccerORM.db',
  databaseTables: [tablePerson],
);
