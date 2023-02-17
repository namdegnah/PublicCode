import 'bar_loader.dart';
import 'bar_details.dart';
import 'dart:math';
import '../../widgets/facts/facts_widgets_export.dart';
import '../../config/constants.dart';
import '../../config/injection_container.dart';
import '../../../domain/entities/setting.dart';

String currencySymbol =Currencies.currencyValue(sl<Setting>().currency);

class Scaler {

  static const dates = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  static int noMonths = 4; 
  static const beta = 3.0 * pi / 180.0;
  static const gamma = 19.0 * pi / 180.0;
  static BarDetails? barDetails;
  static List<String> verticalTags = [];
  // static List<double> values;

  static void setBarDetails(int width, int height){
    List<BarDetails> bd = getBarDetails();
    if(width <= 400 && height <= 620){
      if(noMonths == FactsSendEvent.portrait){
        barDetails = bd.firstWhere((b) => b.name == 'Small Portrait');
      } else {
        barDetails = bd.firstWhere((b) => b.name == 'Small Landscape');
      }
    } else if(width <= 480 && height > 620){
      if(noMonths == FactsSendEvent.portrait){
        barDetails = bd.firstWhere((b) => b.name == 'Medium Portrait');
      } else {
        barDetails = bd.firstWhere((b) => b.name == 'Medium Landscape');
      }            
    } else if(width > 480 && height > 750){
      if(noMonths == FactsSendEvent.portrait){
        barDetails = bd.firstWhere((b) => b.name == 'Large Portrait');
      } else {
        barDetails = bd.firstWhere((b) => b.name == 'Large Landscape');
      }            
    } else {
      if(noMonths == FactsSendEvent.portrait){
        barDetails = bd.firstWhere((b) => b.name == 'Small Portrait');
      } else {
        barDetails = bd.firstWhere((b) => b.name == 'Small Landscape');
      }      
    }
  }

  static void twoDigits({required List<BarLoader> loaders, required int scaleMax5, required int scaleMax4, required int value, required String extras, required int power}){
    
    if(value <= 20){
      processVerticalTags(tags: [5, 10, 15, 20], extras: extras);
      processLoaders(loaders: loaders, topValue: 20, scale: scaleMax4, power: power);
    } else if (value <= 30){
      processVerticalTags(tags: [10, 20, 30, 40], extras: extras);
      processLoaders(loaders: loaders, topValue: 40, scale: scaleMax4, power: power);
    } else if (value <= 40){
      processVerticalTags(tags: [10, 20, 30, 40], extras: extras);
      processLoaders(loaders: loaders, topValue: 40, scale: scaleMax4, power: power);
    } else if (value <= 50){
      processVerticalTags(tags: [10, 20, 30, 40, 50], extras: extras);
      processLoaders(loaders: loaders, topValue: 50, scale: scaleMax5, power: power);
    } else if (value <= 60){
      processVerticalTags(tags:[15, 30, 45, 60], extras: extras);
      processLoaders(loaders: loaders, topValue: 60, scale: scaleMax4, power: power);      
    } else if (value <= 70){
      processVerticalTags(tags: [20, 40, 60, 80], extras: extras);
      processLoaders(loaders: loaders, topValue: 80, scale: scaleMax4, power: power);      
    } else if (value <= 80){
      processVerticalTags(tags: [20, 40, 60, 80], extras: extras);
      processLoaders(loaders: loaders, topValue: 80, scale: scaleMax4, power: power);      
    } else if (value <= 90){
      processVerticalTags(tags: [20, 40, 60, 80, 100], extras: extras);
      processLoaders(loaders: loaders, topValue: 100, scale: scaleMax5, power: power);      
    } else if (value <= 100){
      processVerticalTags(tags: [20, 40, 60, 80, 100], extras: extras);
      processLoaders(loaders: loaders, topValue: 100, scale: scaleMax5, power: power);       
    }
  }
  static void oneDigit({required List<BarLoader> loaders, required int scaleMax5, required int scaleMax4, required int value}){
    if(value <= 1){
      verticalTags = ['0.2', '0.4', '0.6', '0.8', '1'];
      processLoaders(loaders: loaders, topValue:1, scale: scaleMax5, power: 1);
    } else if (value <= 2){
      verticalTags = ['0.4', '0.8', '1.2', '1.6', '2'];
      processLoaders(loaders: loaders, topValue: 2, scale: scaleMax5, power: 1);
    } else if (value <= 3){
      verticalTags = ['1', '2', '3', '4'];
      processLoaders(loaders: loaders, topValue: 4, scale: scaleMax4, power: 1);
    } else if (value <= 4){
      verticalTags = ['1', '2', '3', '4'];
      processLoaders(loaders: loaders, topValue: 4, scale: scaleMax4, power: 1);
    } else if (value <= 5){
      verticalTags = ['1', '2', '3', '4', '5'];
      processLoaders(loaders: loaders, topValue: 5, scale: scaleMax5, power: 1);      
    } else if (value <= 6){
      verticalTags = ['2', '4', '6', '8'];
      processLoaders(loaders: loaders, topValue: 8, scale: scaleMax4, power: 1);      
    } else if (value <= 7){
      verticalTags = ['2', '4', '6', '8'];
      processLoaders(loaders: loaders, topValue: 8, scale: scaleMax4, power: 1);      
    } else if (value <= 8){
      verticalTags = ['2', '4', '6', '8'];
      processLoaders(loaders: loaders, topValue: 8, scale: scaleMax4, power: 1);      
    } else if (value <= 9){
      verticalTags = ['2', '4', '6', '8', '10'];
      processLoaders(loaders: loaders, topValue: 10, scale: scaleMax5, power: 1);       
    }    
  }
  static void moreDigits({required List<BarLoader> loaders, required int digits, required int scaleMax5, required int scaleMax4, required int value}){
    int used = (value / pow(10, digits - 2)).round();
 
    if(digits < 5){
      //when 10000, make it 10k when 2000 make it 2k
      twoDigits(loaders: loaders, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: used, extras: zeros(digits - 2), power: pow(10, digits - 2) as int);
    }
    if(digits > 4 && digits < 8){
      //this is the k part so 10000 is 10k 80,000 is 80k 240,000 is 240k
      twoDigits(loaders: loaders, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: used, extras: zeros(digits - 5) + 'k', power: pow(10, digits - 2) as int);
    }
    if(digits > 7 && digits < 11){
      //this is the m part so 10,000,000 is 10m, 80,000,000 is 80m, 240,000,000 is 240m
      twoDigits(loaders: loaders, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: used, extras: zeros(digits - 8) + 'm', power: pow(10, digits - 2) as int);
    }
    if(digits > 10 && digits < 14){
      //Billions now
      twoDigits(loaders: loaders, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: used, extras: zeros(digits - 11) + 'b', power: pow(10, digits - 2) as int);
    }
    if(digits > 13 && digits < 17){
      //Trillions now
      twoDigits(loaders: loaders, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: used, extras: zeros(digits - 14) + 't', power: pow(10, digits - 2) as int);
    }   
    if(digits > 16 && digits < 20){
      //Zillions now
      twoDigits(loaders: loaders, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: used, extras: zeros(digits - 17) + 'z', power: pow(10, digits - 2) as int);
    }     
  }
  static void processLoaders({required List<BarLoader> loaders, required int topValue, required int scale, required int power}){
    List<String> labels = Scaler.dateNames(loaders.length);
    int i = 0;
    for(var loader in loaders){
      loader.value = (scale * loader.height / (topValue * power)).abs();
      loader.label = labels[i];
      i++;
    }
  }
  static void processVerticalTags({required List<int> tags, required String extras}){
    
    List<String> stags = []; 
    for(int i = 0; i < tags.length; i++){
      var out = extras ?? '';
      stags.add(tags[i].toString() + out);
    } 
    verticalTags = stags;
  }
  static String zeros(int number){
    String result = '';
    for(var i = 0; i < number; i++){
      result += '0';
    }
    return result;
  }
  static List<String> dateNames(int n){
    var extras = 0;
    List<String> names = [];
    late int month, first, last;
    month = DateTime.now().month;
    first = month - 1;
    if(month + n - 1 > dates.length){
        last = dates.length - 1;
        extras = n + month - 1 - dates.length;
    } else {
      last = month - 1 + n - 1;
    }
    for(int i = first; i <= last; i++){
      names.add(dates[i]);
    }
    if(extras != 0){
      for(int i = 0; i < extras; i++){
        names.add(dates[i]);
      }
    }
    return names;
  }
}