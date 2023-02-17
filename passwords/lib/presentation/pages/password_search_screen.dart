import 'package:flutter/material.dart';
import '../../domain/entities/password.dart';
import '../../domain/usecases/search_calls.dart' as calls;
import '../config/style/app_colours.dart';
import '../config/style/text_style.dart';
import '../widgets/common_widgets.dart';
import '../widgets/password/password_list_tile.dart';

class PasswordSearchScreen extends StatefulWidget {
  const PasswordSearchScreen({required this.data, super.key});
  final List<Password> data;

  @override
  State<PasswordSearchScreen> createState() => _PasswordSearchScreenState();
}

class _PasswordSearchScreenState extends State<PasswordSearchScreen> {

  bool dirty = false;
  late final _searchTextController = TextEditingController();
  void _validationComplete() {
    setState(() {
      calls.userInput(_searchTextController.text);     
    });
  }
  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  } 
  @override
  void initState() {
    super.initState();
    calls.fulldata = widget.data;
    _searchTextController.addListener(_validationComplete);
  }
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }     
  @override
  Widget build(BuildContext context) {
    if(dirty){
      rebuildAllChildren(context);
      dirty = false;
    }
    var scaffold = Scaffold();    
    scaffold = Scaffold(
      backgroundColor: mainBackground,
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: buttonFast,
            title: Text("SEARCH PASSWORDS", style: unfocussed,),
          ),
        ]),
        body: SafeArea(child: buildPage(scaffold)),
      ),

    );
    return scaffold;
  }
  Widget buildPage(Scaffold scaffold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10,),
        _getSearchTop(context),
        Flexible(
          child: ListView.builder(
            itemCount: calls.noItemsToShow(),
            itemBuilder: (context, index){
              final password = calls.results[index];
              return PasswordListTile(password, scaffold);                 
            }
          ),
        ),        
      ],
    );
  }
  Widget _getSearchTop(BuildContext context){

    Widget notMobileBox = SizedBox(
      height: 50,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 10,),
              // const Spacer(),
              // const SizedBox(width: 10,),
            ],
          ),
          // const SizedBox(height: 20,),
          searchBox(),
          
        ],
      ),
    );    
    return notMobileBox;
  } 
  Widget searchBox(){
    return Row(
      children: [                
        SizedBox(width: 10,),
        LimitedBox(
          maxWidth: MediaQuery.of(context).size.width - 20,
          maxHeight: 48,
          child: TextField(
            controller: _searchTextController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.black45,),
              hintText: "Enter start or part of description",
              border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black45, width: 0.5)),
            ),              
          ),
        ),                            
      ],
    );
  }      
//========================================================================= 
}