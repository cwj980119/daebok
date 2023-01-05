import 'package:flutter/cupertino.dart';

class PrintNBook {
  String kind = "printnbook";
  String? size;
  int? quantity;
  int? total_page;
  int? addtional_price;
  String? binding_style;
  String? color;
  String? filetype;
  String? paper_type;
  String? side;
  String? book_thickness;
  String? reminder;

  List size_list = ['A5', 'B5', 'A4', 'B4', 'A3'];
  List binding_style_list = ['없음', '책', '링', '3공', '스테플'];
  List color_list = ['흑백', '칼라 레이져', '칼라 잉크젯'];
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
    data['addtional_price'] = addtional_price;
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
    this.addtional_price = 0;
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
    this.addtional_price = 0;
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
    addtional_price = value;
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
  String? black_picture;
  String? paper_type;
  String? percentage;
  String? reminder;
  String? staple;
  String? thickness;
  int price = 0;

  List size_list = ['A2', 'A1', 'A0'];
  List color_list = ['흑백', '칼라'];
  List black_picture_list = ['50% 미만', '50% 이상'];
  List paper_type_list = ['일반지', '칼라지', '유포지', '인화지', '캔버스지'];
  List percentage_list = ['20이하', '20~50', '50이상'];
  List staple_list = ['없음', '스태플'];
  List thickness_list = ['~10mm', '~20mm', '~30mm'];

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
  Map<String, Map<String, int>> StapleFee = {
    'A2': {
      '~10mm': 30000,
      '~20mm': 35000,
      '~30mm': 40000,
    },
    'A1': {
      '~10mm': 40000,
      '~20mm': 45000,
      '~30mm': 50000,
    },
  };

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['size'] = size;
    data['quantity'] = quantity;
    data['color'] = color;
    data['black_picture'] = black_picture;
    data['paper_type'] = paper_type;
    data['percentage'] = percentage;
    data['staple'] = staple;
    data['thickness'] = thickness;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  BigPrint.fromJson(dynamic json)
      : kind = json['kind'],
        size = json['size'],
        quantity = json['quantity'],
        color = json['color'],
        black_picture = json['black_picture'],
        paper_type = json['paper_type'],
        percentage = json['percentage'],
        staple = json['staple'],
        thickness = json['thickness'],
        reminder = json['reminder'],
        price = json['price'];

  BigPrint() {
    this.size = this.size_list[0];
    this.quantity = 0;
    this.color = this.color_list[0];
    this.black_picture = this.black_picture_list[0];
    this.paper_type = paper_type_list[0];
    this.percentage = percentage_list[0];
    this.staple = staple_list[0];
    this.thickness = thickness_list[0];
    this.reminder = "";
  }

  Reset() {
    this.size = this.size_list[0];
    this.quantity = 0;
    this.color = this.color_list[0];
    this.black_picture = this.black_picture_list[0];
    this.paper_type = paper_type_list[0];
    this.percentage = percentage_list[0];
    this.staple = staple_list[0];
    this.thickness = thickness_list[0];
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    reminderController.clear();
  }

  calcFee() {
    if (quantity == 0) return;
    int? fee = 0;
    int stapleFee = 0;
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
      if (black_picture == '50% 이상') fee = (fee! * 2)!;
    } else {
      fee = ColorFee[size]![paper_type]![percentage];
    }

    if (staple != '없음') {
      stapleFee = StapleFee[size]![thickness]!;
    }

    price = (fee! * quantity!)! + stapleFee;
  }

  setSize(value) {
    size = value.toString();
    if (size == 'A0') staple = staple_list[0];
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

  setBlackPicture(value) {
    black_picture = value.toString();
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

  setStaple(value) {
    if (size == 'A0') return;
    staple = value.toString();
    calcFee();
  }

  setThickness(value) {
    thickness = value.toString();
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

  OtherService.fromJson(dynamic json)
      : kind = json['kind'],
        laminate = json['laminate'],
        scan = json['scan'],
        staple = json['staple'],
        reminder = json['reminder'],
        price = json['price'];

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
  String? board_type;
  String? size;
  int? quantity;
  String? paper_type;
  String? laminate;
  String? book;
  String? reminder;

  int price = 0;

  List board_type_list = ['폼보드', '포맥스3T', '포맥스5T', '포맥스10T', '하드보드'];
  List size_list = ['A4', 'A3', 'A2', 'A1', 'A0'];
  List paper_type_list = ['유포지', '인화지', '켈지(코팅)'];
  List laminate_list = ['안함', '유광'];
  List book_list = ['안함', '책자폼보드'];

  final quantityController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, Map<String, int>> PaperFee = {
    'A4': {
      '유포지': 10000,
      '인화지': 13000,
      '켈지(코팅)': 10000,
    },
    'A3': {
      '유포지': 15000,
      '인화지': 19000,
      '켈지(코팅)': 20000,
    },
    'A2': {
      '유포지': 27000,
      '인화지': 35000,
      '켈지(코팅)': 35000,
    },
    'A1': {
      '유포지': 39000,
      '인화지': 45000,
      '켈지(코팅)': 45000,
    },
    'A0': {
      '유포지': 69000,
      '인화지': 75000,
      '켈지(코팅)': 75000,
    },
  };
  Map<String, Map<String, int>> BoardFee = {
    'A4': {
      '폼보드': 0,
      '포맥스3T': 2000,
      '포맥스5T': 4000,
      '포맥스10T': 6000,
      '하드보드': 0,
    },
    'A3': {
      '폼보드': 0,
      '포맥스3T': 2000,
      '포맥스5T': 4000,
      '포맥스10T': 6000,
      '하드보드': 0,
    },
    'A2': {
      '폼보드': 0,
      '포맥스3T': 3000,
      '포맥스5T': 5000,
      '포맥스10T': 7000,
      '하드보드': 0,
    },
    'A1': {
      '폼보드': 0,
      '포맥스3T': 4000,
      '포맥스5T': 7000,
      '포맥스10T': 9000,
      '하드보드': 0,
    },
    'A0': {
      '폼보드': 0,
      '포맥스3T': 6000,
      '포맥스5T': 9000,
      '포맥스10T': 11000,
      '하드보드': 0,
    },
  };
  Map<String, int> LaminateFee = {
    'A4': 1000,
    'A3': 2000,
    'A2': 5000,
    'A1': 8000,
    'A0': 10000,
  };
  Map<String, int> BookFee = {
    'A4': 5000,
    'A3': 5000,
    'A2': 7000,
    'A1': 7000,
    'A0': 9000,
  };

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['board_type'] = board_type;
    data['size'] = size;
    data['quantity'] = quantity;
    data['paper_type'] = paper_type;
    data['laminate'] = laminate;
    data['book'] = book;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  PormBoard.fromJson(dynamic json)
      : kind = json['kind'],
        board_type = json['board_type'],
        size = json['size'],
        quantity = json['quantity'],
        paper_type = json['paper_type'],
        laminate = json['laminate'],
        book = json['book'],
        reminder = json['reminder'],
        price = json['price'];

  PormBoard() {
    this.board_type = this.board_type_list[0];
    this.size = this.size_list[0];
    this.quantity = 0;
    this.paper_type = paper_type_list[0];
    this.laminate = laminate_list[0];
    this.book = book_list[0];
    this.reminder = "";
  }

  Reset() {
    this.board_type = this.board_type_list[0];
    this.size = this.size_list[0];
    this.quantity = 0;
    this.paper_type = paper_type_list[0];
    this.laminate = laminate_list[0];
    this.book = book_list[0];
    this.reminder = "";
    this.price = 0;
    quantityController.clear();
    reminderController.clear();
  }

  calcFee() {
    if (quantity == 0) return;
    int? fee = 0;
    int? boardFee = 0;
    int? laminateFee = 0;
    int? bookFee = 0;
    fee = PaperFee[size]![paper_type];
    boardFee = BoardFee[size]![board_type];
    if (paper_type != '켈지(코팅)' && laminate == '유광')
      laminateFee = LaminateFee[size];
    if (book != '안함') bookFee = BookFee[size];

    price = (fee! + boardFee! + laminateFee! + bookFee!) * quantity!;
  }

  setSize(value) {
    size = value.toString();
    calcFee();
  }

  setBoardType(value) {
    board_type = value.toString();
    calcFee();
  }

  setQuantity(value) {
    quantity = value;
    calcFee();
  }

  setLaminate(value) {
    laminate = value.toString();
    calcFee();
  }

  setPaperType(value) {
    paper_type = value.toString();
    calcFee();
  }

  setBook(value) {
    book = value.toString();
    calcFee();
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
  String? si_quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List paper_type_list = ['일반지', '수입지'];
  List side_list = ['단면', '양면'];
  List quantity_list = ['수량선택', '200장', '500장', '1,000장', '5,000장', '10,000장'];
  List si_quantity_list = ['수량선택', '200장', '400장', '600장', '800장', '1,000장'];

  final designPageController = TextEditingController();
  final addtionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['paper_type'] = paper_type;
    data['side'] = side;
    data['quantity'] = quantity;
    data['si_quantity'] = si_quantity;
    data['design_page'] = design_page;
    data['addtional_price'] = addtional_price;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  NameCard.fromJson(dynamic json)
      : kind = json['kind'],
        paper_type = json['paper_type'],
        side = json['side'],
        quantity = json['quantity'],
        si_quantity = json['si_quantity'],
        design_page = json['design_page'],
        addtional_price = json['addtional_price'],
        reminder = json['reminder'],
        price = json['price'];

  NameCard() {
    this.paper_type = paper_type_list[0];
    this.side = side_list[0];
    this.quantity = quantity_list[0];
    this.si_quantity = si_quantity_list[0];
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  Reset() {
    this.paper_type = paper_type_list[0];
    this.side = side_list[0];
    this.quantity = quantity_list[0];
    this.si_quantity = si_quantity_list[0];
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
        '400장': 29000,
        '600장': 39000,
        '800장': 49000,
        '1,000장': 59000
      },
      '양면': {
        '200장': 24000,
        '400장': 39000,
        '600장': 49000,
        '800장': 59000,
        '1,000장': 69000
      }
    },
  };

  calcFee() {
    if (quantity == '수량선택' && si_quantity == '수량선택') {
      price = 0;
      return;
    }
    int? fee = 0;
    if (paper_type == '일반지')
      fee = Fee[paper_type]![side]![quantity];
    else
      fee = Fee[paper_type]![side]![si_quantity];
    price = fee! + design_page! + addtional_price!;
  }

  setPaperType(value) {
    quantity = '수량선택';
    si_quantity = '수량선택';
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

  setSiQuantity(value) {
    si_quantity = value.toString();
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
  String? fold;
  String? paper_type;
  String? quantity;
  String? a3_quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List size_list = ['A3', 'A4', 'B4'];
  List side_list = ['양면'];
  List fold_list = ['없음', '1단', '2단', '3단', '4단이상'];
  List paper_type_list = ['일반지', '수입지'];
  List quantity_list = ['수량선택','400장', '800장', '1200장','1600장', '2000장'];
  List a3_quantity_list = ['수량선택' , '200장', '400장', '600장','800장','1000장'];

  //final quantityController = TextEditingController();
  final designPageController = TextEditingController();
  final addtionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['size'] = size;
    data['side'] = side;
    data['fold'] = fold;
    data['paper_type'] = paper_type;
    data['quantity'] = quantity;
    data['a3_quantity'] = a3_quantity;
    data['design_page'] = design_page;
    data['addtional_price'] = addtional_price;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  Leaflet.fromJson(dynamic json)
      : kind = json['kind'],
        size = json['size'],
        side = json['side'],
        fold = json['fold'],
        paper_type = json['paper_type'],
        quantity = json['quantity'],
        a3_quantity = json['a3_quantity'],
        design_page = json['design_page'],
        addtional_price = json['addtional_price'],
        reminder = json['reminder'],
        price = json['price'];

  Leaflet() {
    this.size = size_list[0];
    this.side = side_list[0];
    this.fold = fold_list[0];
    this.paper_type = paper_type_list[0];
    this.quantity = quantity_list[0];
    this.a3_quantity = a3_quantity_list[0];
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  Reset() {
    this.size = size_list[0];
    this.side = side_list[0];
    this.fold = fold_list[0];
    this.paper_type = paper_type_list[0];
    this.quantity = quantity_list[0];
    this.a3_quantity = a3_quantity_list[0];
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
    this.price = 0;
    //quantityController.clear();
    designPageController.clear();
    addtionalPriceController.clear();
    reminderController.clear();
  }

  Map<String, Map<String, Map<String, int>>> Fee = {
    'A3': {
      '단면': {
        '200장': 19000,
        '500장': 29000,
        '1,000장': 49000,
        '5,000장': 79000,
        '10,000장': 129000
      },
      '양면': {
        '200장': 320000,
        '400장': 340000,
        '600장': 360000,
        '800장': 380000,
        '1000장': 400000
      }
    },
    'A4': {
      '단면': {
        '200장': 19000,
        '400장': 29000,
        '600장': 39000,
        '800장': 49000,
        '1,000장': 59000
      },
      '양면': {
        '400장': 320000,
        '800장': 340000,
        '1200장': 360000,
        '1600장': 380000,
        '2000장': 400000
      }
    },
    'B4': {
      '단면': {
        '200장': 19000,
        '400장': 29000,
        '600장': 39000,
        '800장': 49000,
        '1,000장': 59000
      },
      '양면': {
        '400장': 340000,
        '800장': 370000,
        '1200장': 400000,
        '1600장': 430000,
        '2000장': 460000
      }
    },
  };

  calcFee() {
    int? fee = 0;
    int total_fee = 0;
    if(size == 'A3') {
      if(a3_quantity!='수량선택') fee = Fee[size]![side]![a3_quantity];
      else {
        price = 0;
        return;
      }
    }
    else {
      if(quantity!='수량선택') fee = Fee[size]![side]![quantity];
      else {
        price = 0;
        return;
      }
    }
    if(fold ==  '4단이상'){
      if(size == 'B4'){
        total_fee = fee! + 140000;
      }
      else{
        total_fee = fee! + 130000;
      }
    }
    else total_fee = fee!;

    if(paper_type == '수입지') {
      if(size =='A3') total_fee += 50000;
      else if(size =='A4') total_fee += 30000;
      else if(size =='B4') total_fee += 80000;
    }

    price = total_fee + design_page! + addtional_price!;

  }

  setSize(value) {
    size = value.toString();
    calcFee();
  }

  setSide(value) {
    side = value.toString();
    calcFee();
  }

  setFold(value) {
    fold = value.toString();
    calcFee();
  }

  setPaperType(value) {
    paper_type = value.toString();
    calcFee();
  }



  setQuantity(value) {
    quantity = value.toString();
    calcFee();
  }
  setA3Quantity(value) {
    a3_quantity = value.toString();
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

  List paper_type_list = ['일반', '도무송', '주차'];
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

  Sticker.fromJson(dynamic json)
      : kind = json['kind'],
        paper_type = json['paper_type'],
        laminate = json['laminate'],
        size = json['size'],
        quantity = json['quantity'],
        design_page = json['design_page'],
        addtional_price = json['addtional_price'],
        reminder = json['reminder'],
        price = json['price'];

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
  String? big_paper_type;
  String? color;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List size_list = ['소', '대'];
  List paper_type_list = ['모조 100', '줄 레자크', '체크 레자크'];
  List big_paper_type_list = ['모조 120', '줄 레자크', '체크 레자크', '크라프트'];
  List color_list = ['흑백', '칼라'];

  final quantityController = TextEditingController();
  final designPageController = TextEditingController();
  final addtionalPriceController = TextEditingController();
  final reminderController = TextEditingController();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['kind'] = kind;
    data['size'] = size;
    data['paper_type'] = paper_type;
    data['big_paper_type'] = big_paper_type;
    data['color'] = color;
    data['quantity'] = quantity;
    data['design_page'] = design_page;
    data['addtional_price'] = addtional_price;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  Envelope.fromJson(dynamic json)
      : kind = json['kind'],
        size = json['size'],
        paper_type = json['paper_type'],
        big_paper_type = json['big_paper_type'],
        color = json['color'],
        quantity = json['quantity'],
        design_page = json['design_page'],
        addtional_price = json['addtional_price'],
        reminder = json['reminder'],
        price = json['price'];

  Envelope() {
    this.size = size_list[0];
    this.paper_type = paper_type_list[0];
    this.big_paper_type = big_paper_type_list[0];
    this.color = color_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  Reset() {
    this.size = size_list[0];
    this.paper_type = paper_type_list[0];
    this.big_paper_type = big_paper_type_list[0];
    this.color = color_list[0];
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

  Map<String, Map<String, Map<String, int>>> Fee = {
    '소': {
      '흑백': {
        '모조 100': 70,
        '줄 레자크': 80,
        '체크 레자크': 80,
      },
      '칼라': {
        '모조 100': 70,
        '줄 레자크': 80,
        '체크 레자크': 80,
      }
    },
    '대': {
      '흑백': {
        '모조 120': 110,
        '줄 레자크': 140,
        '체크 레자크': 140,
        '크라프트': 110,
      },
      '칼라': {
        '모조 120': 220,
        '줄 레자크': 240,
        '체크 레자크': 240,
        '크라프트': 230,
      }
    },
  };
  Map<String, Map<String, Map<String, int>>> ExtraFee = {
    '소': {
      '흑백': {
        '모조 100': 70,
        '줄 레자크': 80,
        '체크 레자크': 80,
      },
      '칼라': {
        '모조 100': 70,
        '줄 레자크': 80,
        '체크 레자크': 80,
      }
    },
    '대': {
      '흑백': {
        '모조 120': 70,
        '줄 레자크': 80,
        '체크 레자크': 80,
        '크라프트': 70,
      },
      '칼라': {
        '모조 120': 140,
        '줄 레자크': 160,
        '체크 레자크': 160,
        '크라프트': 130,
      }
    },
  };

  calcFee() {
    if (quantity! <= 0) {
      price = 0;
      return;
    }
    int? f = 0;
    int extrafee = 0;
    int fee = 0;
    if (size == '대' && big_paper_type != '크라프트') {
      if (quantity! > 500) {
        f = (Fee[size]![color]![big_paper_type]! * 500)!;
        extrafee =
            (ExtraFee[size]![color]![big_paper_type]! * (quantity! - 500))!;
        fee = (f! + extrafee)!;
      } else {
        fee = (Fee[size]![color]![paper_type]! * quantity!)!;
      }
    } else {
      if (size == '소') {
        if (quantity! > 1000) {
          f = (Fee[size]![color]![paper_type]! * 1000)!;
          extrafee =
              (ExtraFee[size]![color]![paper_type]! * (quantity! - 1000))!;
          fee = (f! + extrafee)!;
        } else {
          fee = (Fee[size]![color]![paper_type]! * quantity!)!;
        }
      } else {
        if (quantity! > 1000) {
          f = (Fee[size]![color]![big_paper_type]! * 1000)!;
          extrafee =
              (ExtraFee[size]![color]![big_paper_type]! * (quantity! - 1000))!;
          fee = (f! + extrafee)!;
        } else {
          fee = (Fee[size]![color]![big_paper_type]! * quantity!)!;
        }
      }
    }

    price = fee! + design_page! + addtional_price!;
  }

  setPaperType(value) {
    paper_type = value.toString();
    calcFee();
  }

  setBigPaperType(value) {
    big_paper_type = value.toString();
    calcFee();
  }

  setColor(value) {
    color = value.toString();
    calcFee();
  }

  setSize(value) {
    size = value.toString();
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
    calcFee();
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

  MyBanner.fromJson(dynamic json)
      : kind = json['kind'],
        paper_type = json['paper_type'],
        rests = json['rests'],
        quantity = json['quantity'],
        design_page = json['design_page'],
        addtional_price = json['addtional_price'],
        reminder = json['reminder'],
        price = json['price'];

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
    price =
        fee! * quantity! + int.parse(rests!) + design_page! + addtional_price!;
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
