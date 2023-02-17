import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/categories/categories_bloc_exports.dart';
import '../widgets/categories/categories_list.dart';
import '../widgets/common_widgets.dart';
import '../config/constants.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: buildBody(context),
    );
    return scaffold;
  }
}
Builder buildBody(BuildContext context){
  BlocProvider.of<CategoriesBloc>(context).add(GetCategoriesEvent());
  return Builder(
    builder: (context) {
      final userState = context.watch<CategoriesBloc>().state;
      if(userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      } else if (userState is CategoriesState){
        return CategoryList(userState.categories);
      } else if (userState is CategoryDeleteState){
        return CanNotDelete(transactions: userState.transactions, transfers: userState.transfers, type: CategoryNames.single);
      }
      return Center(child: CircularProgressIndicator(),);
    },
  );
  
}
// BlocProvider<CategoriesBloc> buildBodys(BuildContext context) {
//   return BlocProvider(
//     create: (_) => sl<CategoriesBloc>(),
//     child: Column(children: <Widget>[
//       CategoriesSendEvent(),
//       BlocBuilder<CategoriesBloc, CategoriesBlocState>(
//         builder: (_, state){
//           if(state is Empty){
//             return const Text('Empty State');
//           } else if (state is Loading){
//             return Center(child: CircularProgressIndicator(),);
//           } else if (state is CategoriesState){
//             return CategoryList(state.categories);
//           } else if (state is Error){
//             return Text(state.message);
//           } else if (state is CategoryDeleteState){
//             return CanNotDelete(transactions: state.transactions, transfers: state.transfers, type: CategoryNames.single);
//           }
//           return null;
//         }       
//       ),
//     ],),
//   );
// }