import 'package:flutter/material.dart';
import '../../../data/models/facts_base.dart';
import '../../../domain/entities/accounts/cash_item.dart';
//import '../../../domain/entities/accounts/account.dart';
import 'dart:math' as math;
import '../../config/style/text_style.dart';
import '../../bloc/facts/facts_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FactsPage extends StatefulWidget {
  final FactsBase factsbase;
  FactsPage({required this.factsbase});

  @override
  _FactsPageState createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage> {
  double maxCashFlowBalance = 0.0;
  double minCashFlowBalace = 0.0;
  int _noChildren = 0;
  final double _scaleWidth = 260.0;
  double _scaleUsed = 0.0;
  final double _standardScreen = 366.0;
  double _barTotalHeight = 30.0;
  double _cfWidth = 0.0;
  late Color _barColor;
  late AssetImage _barGradient;
  double _barHeight = 23.0;
  late List<CashItem> cashflow;

  @override
  void didChangeDependencies() {
    cashflow = widget.factsbase.cashFlow;
    for (var cfi in cashflow) {
      if (cfi.balance > maxCashFlowBalance) maxCashFlowBalance = cfi.balance;
      if (cfi.balance < minCashFlowBalace) minCashFlowBalace = cfi.balance;
    }
    super.didChangeDependencies();
  }

  void _showDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Transaction Details'),
          content: new Text(cashflow[index].dialogData!),
          actions: <Widget>[
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _noChildren = cashflow.length;
    double _maxScaling = math.max(maxCashFlowBalance, minCashFlowBalace.abs());
    double _screenWidth = MediaQuery.of(context).size.width;
    _scaleUsed = _scaleWidth * _screenWidth / _standardScreen;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                FactsBloc fb = BlocProvider.of<FactsBloc>(context);
                fb.add(RunPauseEvent());
              }),
          iconTheme: IconThemeData(
            color: Colors.black26,
          ),
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  //This is where we want the account name
                  TextSpan(
                      text: widget.factsbase
                          .accountName(widget.factsbase.accountId!),
                      style: stb),
                ],
              ),
            ),
            background: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/cashFlowCoins.png')),
              ),
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: _barTotalHeight,
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              _cfWidth = _scaleUsed * cashflow[index].balance / _maxScaling;
              if (_cfWidth < 0) {
                _barColor = Colors.red;
                _barGradient = AssetImage('assets/images/red_gradient.jpg');
                _cfWidth = _cfWidth.abs();
              } else {
                _barGradient = AssetImage('assets/images/gold-gradient.jpg');
                _barColor = Colors.black;
              }
              return Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _showDialog(context, index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        border: Border(
                            top:
                                BorderSide(width: 1, color: Colors.indigo[900]!),
                            bottom:
                                BorderSide(width: 1, color: Colors.indigo[900]!),
                            left:
                                BorderSide(width: 1, color: Colors.indigo[900]!),
                            right: BorderSide(
                                width: 1, color: Colors.indigo[900]!)),
                        // color: _barColor,
                        image: DecorationImage(
                          image: _barGradient,
                          fit: BoxFit.fill,
                        ),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: _scaleUsed,
                        minWidth: _cfWidth >= _scaleUsed ? _scaleUsed : _cfWidth,                           
                        minHeight: _barHeight,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, top: 4),
                        child: Text(''),
                      ),
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                        onTap: () {
                          _showDialog(context, index);
                        },
                        child: Text(
                          cashflow[index].summary!,
                          style: TextStyle(fontSize: 10, color: _barColor),
                        )),
                    left: _cfWidth + 10,
                    top: 8,
                  ),
                ],
              );
            },
            childCount: _noChildren,
          ),
        ),
      ],
    );
  }
}
