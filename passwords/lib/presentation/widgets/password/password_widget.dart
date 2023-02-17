import 'package:flutter/material.dart';
import 'package:passwords/domain/entities/password_field.dart';
import 'package:passwords/presentation/config/constants.dart';
import '../../../domain/entities/type.dart';
import '../../../domain/entities/password.dart';
import '../../config/injection_container.dart';
import '../../../data/models/data_set.dart';

class PasswordWidget extends StatefulWidget {
  final Password password;
  final GlobalKey<FormState> form;
  //final Function saveF;
  const PasswordWidget(this.password, this.form, {Key? key}) : super(key: key);

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {

  @override
  Widget build(BuildContext context) {
    final int typeId = widget.password.typeId;
    final Type type = sl<DataSet>().types!.firstWhere((element) => element.id == typeId,);
    widget.password.passwordValidationId = type.passwordValidationId; // set the new password to match the type validation.
    final List<PasswordField> fields = type.fieldList!;
    final nodes = List<FocusNode>.filled(fields.length, FocusNode());
    final widgets = fields.getWidgets(nodes: nodes, context: context, password: widget.password);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: widget.form,
          child: Column(
            children: widgets,
          ),
        ),
      ),
    );
  }
}