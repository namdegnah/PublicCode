import 'package:flutter/material.dart';
import '../config/style/app_colours.dart';
import '../config/style/text_style.dart';
import '../config/style/style_extensions.dart';
import '../config/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';
import '../../core/util/general_util.dart';

double innerCircleDiameter = 8;
double statusRectangleWidth = 100;
double statusRectangleHeight = 24;
const int largeScreenSize = 1366;
const int mediumScreenSize = 790;
const int smallScreenSize = 500;
const int customScreenSize = 1000;
const int mobileScreenSize = 499;
int pending = 1;

Widget routeLink({
  required String text,
  required Future<void> Function()? onTap,
  TextStyle? linkStyle,
  }){
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: linkStyle == null ? Text(text) : Text(text, style: linkStyle,),
    ),
  );
}
bool isMoreThanParticlarSizeScreen(BuildContext context, double size) => 
  MediaQuery.of(context).size.width > size;
  
bool isMoreThanMediumScreen(BuildContext context) => 
  MediaQuery.of(context).size.width > mediumScreenSize;

bool isMoreThanCustomScreen(BuildContext context) =>
  MediaQuery.of(context).size.width > customScreenSize;

bool isMoreThanSmallScren(Size size) =>
  size.width > smallScreenSize;

bool isMobileScreen(BuildContext context) =>
   MediaQuery.of(context).size.width < mobileScreenSize;

bool isSmallScreen(BuildContext context) => 
  MediaQuery.of(context).size.width < mediumScreenSize && 
  MediaQuery.of(context).size.width >= mobileScreenSize;     

bool isMediumScreen(BuildContext context) => 
  MediaQuery.of(context).size.width >= mediumScreenSize &&
  MediaQuery.of(context).size.width < largeScreenSize;

bool isLargeScreen(BuildContext context) => 
  MediaQuery.of(context).size.width >= largeScreenSize; 

bool isCustomScreen(BuildContext context) => 
  MediaQuery.of(context).size.width >= mediumScreenSize &&
  MediaQuery.of(context).size.width <= customScreenSize;
int removeAccountPrefix(String accountId, String prefix){
  String possible = accountId.substring(prefix.length, accountId.length);
  int? poss = int.tryParse(possible);
  if(poss != null){
    return poss;
  } else {
    return -1;
  }
}
Widget anyText({
  required String text,
  required TextStyle style,
  double? size,
  double? height,
  FontWeight? weight, 
  Color? color,
  TextDecoration? decoration,
  double? letterSpacing,
  double? left,
  double? right,
  double? top,
  double? bottom,
  bool? bigSize,
}){
  style = style.copyWith(letterSpacing: letterSpacing);
  style = style.copyWith(decoration: decoration);
  style = style.copyWith(fontSize: size);
  style = style.copyWith(height: height);
  style = style.copyWith(fontWeight: weight);
  style = style.copyWith(color: color); 
  if(!(bigSize ?? true)) style = style.copyWith(fontSize: 2 * style.fontSize!/3);
  return Padding(
    padding: EdgeInsets.only(
      left: left ?? 0,
      right: right ?? 0,
      top: top ?? 0,
      bottom: bottom ?? 0,
    ),
    child: Text(text, style: style,),
  );
}
class CanSize{
  late bool _size;
  set size(bool size) => _size = size;
}
int getNextAccountNumber(){
  int currentMax = sl<SharedPreferences>().getInt(AppConstants.maxAccountNumber)!;
  currentMax++;
  sl<SharedPreferences>().setInt(AppConstants.maxAccountNumber, currentMax);
  return currentMax;
}
int getCurrentAccountNumber(){
  return sl<SharedPreferences>().getInt(AppConstants.maxAccountNumber)!;  
}
int getCurrentUserId(){
  int user_id = sl<SharedPreferences>().getInt(AppConstants.userId)!;
  return user_id;  
}
void setHasBeenDoneOnce(){
  sl<SharedPreferences>().setInt(AppConstants.doOnce, AppConstants.doOnceDone);
}
int getHasBeenDone(){
  return sl<SharedPreferences>().getInt(AppConstants.doOnce)!;
}
DateTime getLastDate(){
  return GeneralUtil.timeFromInt(sl<SharedPreferences>().getInt(AppConstants.lastDate)!);
}
void setLastDate(DateTime date){
  sl<SharedPreferences>().setInt(AppConstants.lastDate, GeneralUtil.intFromTime(date));
}
int numberOfDaysThisYear(){
    int year = DateTime.now().year;
    if((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)){
      return 366;
    }
    return 365;
  }
Widget getNavWidget(IconData icondata, String tooltip, VoidCallback? onPressed){
  Icon icon = Icon(icondata, color: (onPressed == null) ? simplyBlack : clearFilterText);
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onPressed,
      child: Tooltip(
        message: tooltip,
        child: icon,
      ),
    ),
  );
}
Widget getTitleWidget(String label, int flex, VoidCallback? onPressed, String tooltip){
  return Expanded(
    flex: flex,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: customerData,),
        const SizedBox(width: 3,),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onPressed,
            
            child: Tooltip(
              message: tooltip,
              child: Icon(
                Icons.sort,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
class IconListImage extends StatelessWidget {
  final double sized;
  final String iconPath;

  IconListImage(this.iconPath, this.sized);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized,
      height: sized,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(iconPath),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
class CanNotDelete extends StatelessWidget {

  final List<String> transactions;
  final List<String> transfers;
  final String type;
  CanNotDelete({required this.transactions, required this.transfers, required this.type});
  final double pad = 10.0;
  final double padding = 3.0;
  final double sized = 16.0;

  Widget processTransactions(){

    List<Widget> list = [];
    list.add(Text('Can not delete $type').buff(pad: pad));
    if(transactions.length > 0) list.add(
      Text('Transactions that contain this $type').buff(pad: pad)); 
      
    for(var i = 0; i < transactions.length; i++){
      list.add(Text(transactions[i]).polish(pad:padding, size:sized));
    }
    if(transactions.length > 0) list.add(SizedBox(height: 13));
    return new Column(children: list);
  }
  Widget processTransfers(){
    List<Widget> list = [];
    if(transfers.length > 0) list.add(
      Text('Transfers that contain this $type').buff(pad: pad));

    for(var i = 0; i < transfers.length; i++){
      list.add(Text(transfers[i]).polish(pad:padding, size:sized));
    }
     if(transfers.length > 0) list.add(SizedBox(height: 13));
    return Column(children: list);
  }  
  @override
  Widget build(BuildContext context) {
         
    return Expanded(
      child: ListView(children: <Widget>[
        processTransactions(),
        processTransfers(),
        ElevatedButton(
          child: const Text('Return'),
          onPressed: () => Navigator.pop(context),
        ).paddLR(40),
      ],).paddAll(20), 
    );
  }
}