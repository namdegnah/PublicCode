import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/config/injection_container.dart';
import '../../presentation/bloc/password/password_bloc.dart';
import '../../presentation/bloc/password/password_bloc_events.dart';
import '../../presentation/pages/password_screen.dart';
import '../../presentation/widgets/password/password_insert_step.dart';
import '../../../domain/entities/password.dart';

void navigateAndDisplayPassword(BuildContext context) async {
  var stepResult = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => BlocProvider<PasswordBloc>.value(
        value: sl<PasswordBloc>(),
        child: PasswordInsertStep( // So this changes
          password: Password(id: -1, description: '', groupId: -1, typeId: -1, password: '', notes: '', isValidated: true),
        ),
      ),
    ),
  );
  if(stepResult != null){
    var insertResult = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<PasswordBloc>.value(
          value: sl<PasswordBloc>(),
          child: PasswordScreen( // So this changes
            password: stepResult as Password,
          ),
        ),
      ),
    );
    if (insertResult != null) {
      BlocProvider.of<PasswordBloc>(context).add(InsertPasswordEvent(password: insertResult as Password));
    }            
  }
}
