import 'package:flutter/cupertino.dart';

class PrintNBook {
  String kind = "printnbook";
  String? size;
  int? quantity;
  int? total_page;
  int? additional_price;
  String? binding_style;
  String? color;
  String? filetype;
  String? paper_type;
  String? side;
  String? book_thickness;
  String? reminder;

  List size_list = ['A5', 'B5', 'A4', 'B4', 'A3'];
  List binding_style_list = ['일반', '책', '링', '3공', '스테플'];
  List color_list = ['흑백', '칼라'];
  List filetype_list = ['PDF', 'JPEG', 'AUTOCAD', 'AI'];
  List paper_type_list = ['일반지', '칼라지', '특수지'];
  List side_list = ['단면', '양면'];
  List book_thickness_list = ['책 아님', '1~20', '21~30', '31~40', '41~50', '51~'];

  final quantityController = TextEditingController();
  final totalPageController = TextEditingController();
  final additionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  int price = 0;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['size'] = size;
    data['quantity'] = quantity;
    data['total_page'] = total_page;
    data['additional_price'] = additional_price;
    data['binding_style'] = binding_style;
    data['color'] = color;
    data['filetype'] = filetype;
    data['book_thickness'] = book_thickness;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  PrintNBook() {
    this.size = this.size_list[0];
    this.quantity = 0;
    this.total_page = 0;
    this.binding_style = this.binding_style_list[0];
    this.color = this.color_list[0];
    this.filetype = this.filetype_list[0];
    this.paper_type = this.paper_type_list[0];
    this.side = this.side_list[0];
    this.book_thickness = this.book_thickness_list[0];
    this.additional_price = 0;
    this.reminder = "";
  }

  Reset() {
    this.size = this.size_list[0];
    this.quantity = 0;
    this.total_page = 0;
    this.binding_style = this.binding_style_list[0];
    this.color = this.color_list[0];
    this.filetype = this.filetype_list[0];
    this.paper_type = this.paper_type_list[0];
    this.side = this.side_list[0];
    this.book_thickness = this.book_thickness_list[0];
    this.additional_price = 0;
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    totalPageController.clear();
    additionalPriceController.clear();
    reminderController.clear();
  }

  setSize(value) {
    size = value.toString();
  }

  setQuantity(value) {
    quantity = value;
  }

  setTotalPage(value) {
    total_page = value;
  }

  setBookStyle(value) {
    binding_style = value.toString();
  }

  setColor(value) {
    color = value.toString();
  }

  setFileType(value) {
    filetype = value.toString();
  }

  setPaperType(value) {
    paper_type = value.toString();
  }

  setSide(value) {
    side = value.toString();
  }

  setThickness(value) {
    book_thickness = value.toString();
  }

  setAdditionalPrice(value) {
    additional_price = value;
  }

  setReminder(value) {
    reminder = value.toString();
  }
}

class BigPrint {
  String kind = "bigprint";
  String? size;
  int? quantity;
  String? color;
  String? paper_type;
  String? percentage;
  String? reminder;
  int price = 0;

  List size_list = ['A2', 'A1', 'A0'];
  List color_list = ['흑백', '칼라'];
  List paper_type_list = ['일반지', '칼라지', '유포지', '인화지', '캔버스지'];
  List percentage_list = ['20이하', '20~50', '50이상'];

  final quantityController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, Map<String, int>> BlackFee = {
    'A2': {
      '1': 3000,
      '11': 2000,
      '51': 1200,
      '101': 1000,
      '201': 900,
      '301': 800
    },
    'A1': {
      '1': 4000,
      '11': 3000,
      '51': 1500,
      '101': 1200,
      '201': 1100,
      '301': 1000
    },
    'A0': {
      '1': 5000,
      '11': 4000,
      '51': 3000,
      '101': 2500,
      '201': 2300,
      '301': 2000
    },
  };
  Map<String, Map<String, Map<String, int>>> ColorFee = {
    'A2': {
      '일반지': {
        '20이하': 6000,
        '20~50': 7000,
        '50이상': 9000,
      },
      '칼라지': {
        '20이하': 7000,
        '20~50': 8000,
        '50이상': 10000,
      },
      '유포지': {
        '20이하': 8000,
        '20~50': 9000,
        '50이상': 12000,
      },
      '인화지': {
        '20이하': 9000,
        '20~50': 12000,
        '50이상': 15000,
      },
      '캔버스지': {
        '20이하': 18000,
        '20~50': 24000,
        '50이상': 30000,
      },
    },
    'A1': {
      '일반지': {
        '20이하': 8000,
        '20~50': 9000,
        '50이상': 17000,
      },
      '칼라지': {
        '20이하': 9000,
        '20~50': 13000,
        '50이상': 19000,
      },
      '유포지': {
        '20이하': 10000,
        '20~50': 16000,
        '50이상': 20000,
      },
      '인화지': {
        '20이하': 12000,
        '20~50': 18000,
        '50이상': 25000,
      },
      '캔버스지': {
        '20이하': 24000,
        '20~50': 36000,
        '50이상': 48000,
      },
    },
    'A0': {
      '일반지': {
        '20이하': 10000,
        '20~50': 18000,
        '50이상': 29000,
      },
      '칼라지': {
        '20이하': 12000,
        '20~50': 20000,
        '50이상': 32000,
      },
      '유포지': {
        '20이하': 13000,
        '20~50': 22000,
        '50이상': 34000,
      },
      '인화지': {
        '20이하': 15000,
        '20~50': 25000,
        '50이상': 39000,
      },
      '캔버스지': {
        '20이하': 35000,
        '20~50': 45000,
        '50이상': 55000,
      },
    },
  };

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['size'] = size;
    data['quantity'] = quantity;
    data['color'] = color;
    if (color == '칼라') {
      data['paper_type'] = paper_type;
      data['percentage'] = percentage;
    }
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  BigPrint() {
    this.size = this.size_list[0];
    this.quantity = 0;
    this.color = this.color_list[0];
    this.paper_type = paper_type_list[0];
    this.percentage = percentage_list[0];
    this.reminder = "";
  }

  Reset() {
    this.size = this.size_list[0];
    this.quantity = 0;
    this.color = this.color_list[0];
    this.paper_type = paper_type_list[0];
    this.percentage = percentage_list[0];
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    reminderController.clear();
  }

  calcFee() {
    if (quantity == 0) return;
    int? fee = 0;
    String cnt = '0';
    if (color == '흑백') {
      if (quantity! < 11)
        cnt = '1';
      else if (quantity! < 51)
        cnt = '11';
      else if (quantity! < 101)
        cnt = '51';
      else if (quantity! < 201)
        cnt = '101';
      else if (quantity! < 301)
        cnt = '201';
      else
        cnt = '301';

      fee = BlackFee[size]![cnt];
    } else {
      fee = ColorFee[size]![paper_type]![percentage];
    }
    price = (fee! * quantity!)!;
  }

  setSize(value) {
    size = value.toString();
    calcFee();
  }

  setQuantity(value) {
    quantity = value;
    calcFee();
  }

  setColor(value) {
    color = value.toString();
    calcFee();
  }

  setPaperType(value) {
    paper_type = value.toString();
    calcFee();
  }

  setPercentage(value) {
    percentage = value.toString();
    calcFee();
  }

  setReminder(value) {
    reminder = value.toString();
  }
}

class OtherService {
  String kind = "otherservice";
  int? laminate;
  int? scan;
  int? staple;
  String? reminder;

  int price = 0;

  final laminateController = TextEditingController();
  final scanController = TextEditingController();
  final stapleController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['laminate'] = laminate;
    data['scan'] = scan;
    data['staple'] = staple;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  Reset() {
    this.laminate = 0;
    this.scan = 0;
    this.staple = 0;
    this.reminder = "";
    this.price = 0;
    laminateController.clear();
    scanController.clear();
    stapleController.clear();
    reminderController.clear();
  }

  OtherService() {
    this.laminate = 0;
    this.scan = 0;
    this.staple = 0;
    this.reminder = "";
  }

  sumAll() {
    price = laminate! + scan! + staple!;
  }

  setLaminate(value) {
    laminate = value;
    sumAll();
  }

  setScan(value) {
    scan = value;
    sumAll();
  }

  setStaple(value) {
    staple = value;
    sumAll();
  }

  setReminder(value) {
    reminder = value.toString();
  }
}

class PormBoard {
  String kind = "pormboard";
  String? size;
  int? quantity;
  String? paper_type;
  String? laminate;
  String? reminder;

  int price = 0;

  List size_list = ['A4', 'A3', 'A2', 'A1', 'A0'];
  List paper_type_list = ['유포지', '인화지', '켈지'];
  List laminate_list = ['안함', '유광', '무광'];

  final quantityController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['size'] = size;
    data['quantity'] = quantity;
    data['paper_type'] = paper_type;
    data['laminate'] = laminate;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  PormBoard() {
    this.size = this.size_list[0];
    this.quantity = 0;
    this.paper_type = paper_type_list[0];
    this.laminate = laminate_list[0];
    this.reminder = "";
  }

  Reset() {
    this.size = this.size_list[0];
    this.quantity = 0;
    this.paper_type = paper_type_list[0];
    this.laminate = laminate_list[0];
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    reminderController.clear();
  }

  setSize(value) {
    size = value.toString();
  }

  setQuantity(value) {
    quantity = value;
  }

  setLaminate(value) {
    laminate = value.toString();
  }

  setPaperType(value) {
    paper_type = value.toString();
  }

  setReminder(value) {
    reminder = value.toString();
  }
}

class OffSet {
  String kind = "offset";
  NameCard? nameCard;
  Leaflet? leaflet;
  Sticker? sticker;
  Envelope? envelope;
  MyBanner? banner;
  int price = 0;

  OffSet() {
    this.nameCard = NameCard();
    this.leaflet = Leaflet();
    this.sticker = Sticker();
    this.envelope = Envelope();
    this.banner = MyBanner();
  }

  Reset() {
    nameCard?.Reset();
    leaflet?.Reset();
    sticker?.Reset();
    envelope?.Reset();
    banner?.Reset();
  }

  calcFee() {
    price = nameCard!.price +
        leaflet!.price +
        sticker!.price +
        envelope!.price +
        banner!.price;
  }
}

class NameCard {
  String kind = "namecard";
  String? paper_type;
  String? side;
  String? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List paper_type_list = ['일반지', '수입지'];
  List side_list = ['단면', '양면'];
  List quantity_list = ['수량선택', '200장', '500장', '1,000장', '5,000장', '10,000장'];

  final designPageController = TextEditingController();
  final addtionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['paper_type'] = paper_type;
    data['side'] = side;
    data['quantity'] = quantity;
    data['design_page'] = design_page;
    data['addtional_price'] = addtional_price;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  NameCard() {
    this.paper_type = paper_type_list[0];
    this.side = side_list[0];
    this.quantity = quantity_list[0];
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  Reset() {
    this.paper_type = paper_type_list[0];
    this.side = side_list[0];
    this.quantity = quantity_list[0];
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
    this.price = 0;
    designPageController.clear();
    addtionalPriceController.clear();
    reminderController.clear();
  }

  Map<String, Map<String, Map<String, int>>> Fee = {
    '일반지': {
      '단면': {
        '200장': 19000,
        '500장': 29000,
        '1,000장': 49000,
        '5,000장': 79000,
        '10,000장': 129000
      },
      '양면': {
        '200장': 24000,
        '500장': 34000,
        '1,000장': 59000,
        '5,000장': 89000,
        '10,000장': 139000
      }
    },
    '수입지': {
      '단면': {
        '200장': 19000,
        '500장': 29000,
        '1,000장': 39000,
        '5,000장': 49000,
        '10,000장': 59000
      },
      '양면': {
        '200장': 24000,
        '500장': 39000,
        '1,000장': 49000,
        '5,000장': 59000,
        '10,000장': 69000
      }
    },
  };

  calcFee() {
    if (quantity == '수량선택') return;
    int? fee = 0;
    fee = Fee[paper_type]![side]![quantity];
    price = fee! + design_page! + addtional_price!;
  }

  setPaperType(value) {
    paper_type = value.toString();
    calcFee();
  }

  setSide(value) {
    side = value.toString();
    calcFee();
  }

  setQuantity(value) {
    quantity = value.toString();
    calcFee();
  }

  setDesignPage(value) {
    design_page = value;
    calcFee();
  }

  setAdditionalPrice(value) {
    addtional_price = value;
    calcFee();
  }

  setReminder(value) {
    reminder = value.toString();
  }
}

class Leaflet {
  String kind = "leaflet";
  String? size;
  String? side;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List size_list = ['A5', 'B5', 'A4', 'B4', 'A3'];
  List side_list = ['단면', '양면'];

  final quantityController = TextEditingController();
  final designPageController = TextEditingController();
  final addtionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['size'] = size;
    data['side'] = side;
    data['quantity'] = quantity;
    data['design_page'] = design_page;
    data['addtional_price'] = addtional_price;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  Leaflet() {
    this.size = size_list[0];
    this.side = side_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  Reset() {
    this.size = size_list[0];
    this.side = side_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    designPageController.clear();
    addtionalPriceController.clear();
    reminderController.clear();
  }

  setSize(value) {
    size = value.toString();
  }

  setSide(value) {
    side = value.toString();
  }

  setQuantity(value) {
    quantity = value;
  }

  setDesignPage(value) {
    design_page = value;
  }

  setAdditionalPrice(value) {
    addtional_price = value;
  }

  setReminder(value) {
    reminder = value.toString();
  }
}

class Sticker {
  String kind = "sticker";
  String? paper_type;
  String? laminate;
  String? size;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List paper_type_list = ['일반지', '도무송'];
  List laminate_list = ['없음', '있음'];
  List size_list = [
    '6cm 미만',
    '6cm 이상',
    '10cm 이하',
    '10cm 이상',
    '10 ~ 15cm',
    '15cm 이상'
  ];

  final quantityController = TextEditingController();
  final designPageController = TextEditingController();
  final addtionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['paper_type'] = paper_type;
    data['laminate'] = laminate;
    data['size'] = size;
    data['quantity'] = quantity;
    data['design_page'] = design_page;
    data['addtional_price'] = addtional_price;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  Sticker() {
    this.paper_type = paper_type_list[0];
    this.laminate = laminate_list[0];
    this.size = size_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  Reset() {
    this.paper_type = paper_type_list[0];
    this.laminate = laminate_list[0];
    this.size = size_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    designPageController.clear();
    addtionalPriceController.clear();
    reminderController.clear();
  }

  setPaperType(value) {
    paper_type = value.toString();
  }

  setLaminate(value) {
    laminate = value.toString();
  }

  setSize(value) {
    size = value.toString();
  }

  setQuantity(value) {
    quantity = value;
  }

  setDesignPage(value) {
    design_page = value;
  }

  setAdditionalPrice(value) {
    addtional_price = value;
  }

  setReminder(value) {
    reminder = value.toString();
  }
}

class Envelope {
  String kind = "envelope";
  String? size;
  String? paper_type;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List size_list = ['소', '대'];
  List paper_type_list = ['모조 100', '모조 120', '줄 레자크', '체크 레자크', '크라프트'];

  final quantityController = TextEditingController();
  final designPageController = TextEditingController();
  final addtionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['size'] = size;
    data['paper_type'] = paper_type;
    data['quantity'] = quantity;
    data['design_page'] = design_page;
    data['addtional_price'] = addtional_price;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  Envelope() {
    this.size = size_list[0];
    this.paper_type = paper_type_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  Reset() {
    this.size = size_list[0];
    this.paper_type = paper_type_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    designPageController.clear();
    addtionalPriceController.clear();
    reminderController.clear();
  }

  setPaperType(value) {
    paper_type = value.toString();
  }

  setSize(value) {
    size = value.toString();
  }

  setQuantity(value) {
    quantity = value;
  }

  setDesignPage(value) {
    design_page = value;
  }

  setAdditionalPrice(value) {
    addtional_price = value;
  }

  setReminder(value) {
    reminder = value.toString();
  }
}

class MyBanner {
  String kind = "banner";
  String? paper_type;
  String? rests;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List paper_type_list = ['기본', '투명', '통풍'];
  List rests_list = ['20000', '30000', '40000', '50000'];

  final quantityController = TextEditingController();
  final designPageController = TextEditingController();
  final addtionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['paper_type'] = paper_type;
    data['rests'] = rests;
    data['quantity'] = quantity;
    data['design_page'] = design_page;
    data['addtional_price'] = addtional_price;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  MyBanner() {
    this.paper_type = paper_type_list[0];
    this.rests = rests_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  Map<String, int> Fee = {
    '기본': 20000,
    '투명': 40000,
    '통풍': 40000,
  };

  calcFee() {
    if (quantity == 0) return;
    int? fee = 0;
    fee = Fee[paper_type];
    price = fee!*quantity! + int.parse(rests!) + design_page! + addtional_price!;
  }

  Reset() {
    this.paper_type = paper_type_list[0];
    this.rests = rests_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    designPageController.clear();
    addtionalPriceController.clear();
    reminderController.clear();
  }

  setPaperType(value) {
    paper_type = value.toString();
    calcFee();
  }

  setRests(value) {
    rests = value.toString();
    calcFee();
  }

  setQuantity(value) {
    quantity = value;
    calcFee();
  }

  setDesignPage(value) {
    design_page = value;
    calcFee();
  }

  setAdditionalPrice(value) {
    addtional_price = value;
    calcFee();
  }

  setReminder(value) {
    reminder = value.toString();
  }
}
