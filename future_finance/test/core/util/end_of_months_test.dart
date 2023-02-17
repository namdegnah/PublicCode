import 'package:flutter_test/flutter_test.dart';
import 'package:future_finance/core/util/date_time_extension.dart';

void main(){

  group('End of Months Calculation', (){
    
    test('2018, 01, 13', () {
      //arrage
      DateTime testDate = DateTime(2018, 01, 13); //normal year
      List<int> hashcode = [689590300, 747362537, 856333988, 843698194, 258255313, 247194431, 735524093, 146951868, 134283306, 1000916459, 988778329, 404420888];
      //act
      List<DateTime> result = testDate.endOfNextMonths(12);
      //assert
      for(int i = 0; i < 12; i++){
        expect(result[i].hashCode, equals(hashcode[i]));
      }      
    },); 
    test('2020, 01, 05 with leap year', (){
      //arrange
      DateTime testDate = DateTime(2020, 01, 05); //has leap year in 2020
      List<int> hashcode = [19002769, 579542702, 688444521, 676138455, 90613654, 79419652, 567587522, 1052771456, 1040530926, 833260464, 820991262, 236519133];
      //act
      List<DateTime> result = testDate.endOfNextMonths(12);
      //assert
      for(int i = 0; i < 12; i++){
        expect(result[i].hashCode, equals(hashcode[i]));
      }      
    },);  
    test('Is before or equal', (){
      //arrange
      DateTime early = DateTime(2010, 05, 13);
      DateTime actual = DateTime(2010, 05, 14);
      DateTime equal = DateTime(2010, 05, 14);
      DateTime later = DateTime(2011, 05, 15);
      //act
      bool earlyAnswer = early.isBeforeOrEqual(actual);
      bool equalAnswer = equal.isBeforeOrEqual(actual);
      bool laterAnswer = later.isBeforeOrEqual(actual);
      //assert
      expect(earlyAnswer, true);
      expect(equalAnswer, true);
      expect(laterAnswer, false);
    }); 
    test('Is After or equal', (){
      //arrange
      DateTime early = DateTime(2010, 05, 13);
      DateTime actual = DateTime(2010, 05, 14);
      DateTime equal = DateTime(2010, 05, 14);
      DateTime later = DateTime(2010, 05, 15);
      //act
      bool earlyAnswer = early.isAfterOrEqual(actual);
      bool equalAnswer = equal.isAfterOrEqual(actual);
      bool laterAnswer = later.isAfterOrEqual(actual);
      //assert
      expect(earlyAnswer, false);
      expect(equalAnswer, true);
      expect(laterAnswer, true);
    });    
  }
  );
}