import '../../domain/entities/accounts/account.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/recurrence.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/accounts/account_type.dart';
import '../../domain/entities/accounts/account_add_interest.dart';
import '../../domain/entities/setting.dart';

class DialogBase {
  late List<Account>? _accounts;
  late List<Category>? _categories;
  late List<Recurrence>? _recurrences;
  late List<User>? _users;
  late List<AccountType>? _accountTypes;
  late Setting? _setting;
  late List<AddInterest>? _addInterests;
  late int? _id;
  DialogBase({
    List<Account>? accounts, 
    List<Category>? categories, 
    List<Recurrence>? recurrences, 
    List<User>? users, 
    List<AccountType>? accountTypes,
    List<AddInterest>? addInterests, 
    Setting? setting,
    int? id,
    }){
     _accountTypes = accountTypes; 
     _accounts = accounts; 
     _categories = categories; 
     _users = users; 
     _recurrences = recurrences; 
     _setting = setting;  
     _addInterests = addInterests;
  }
  void set accounts(List<Account>? a) => this._accounts = a;
  void set accountTypes(List<AccountType>? a) => this._accountTypes = a;
  void set categories(List<Category>? c) => this._categories = c;
  void set recurrences(List<Recurrence>? r) => this._recurrences = r;
  void set users(List<User>? u) => this._users = u;
  void set setting(Setting? s) => this._setting = s;
  void set id(int? i) => this._id = i;
  void set addInterests(List<AddInterest>? a) => this._addInterests = a;

  List<Account>? get accounts => _accounts;
  List<AccountType>? get accountTypes => _accountTypes;
  List<Category>? get categories => _categories;
  List<Recurrence>? get recurrences => _recurrences;
  List<User>? get users => _users;
  Setting? get setting => _setting;
  int? get id => _id;
  List<AddInterest>? get addInterests => _addInterests;
}