class PrintNBook{
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

  List size_list = ['A5','B5','A4','B4','A3'];
  List binding_style_list = ['일반','책','링','3공', '스테플'];
  List color_list = ['흑백','칼라'];
  List filetype_list = ['PDF','JPEG','AUTOCAD','AI'];
  List paper_type_list = ['일반지','칼라지','특수지'];
  List side_list = ['단면','양면'];
  List book_thickness_list = ['1~20','21~30','31~40','41~50','51~'];
  int price = 0;

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
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

  PrintNBook(){
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

  setSize(value){
    size = value.toString();
  }

  setQuantity(value){
    quantity = value;
  }

  setTotalPage(value){
    total_page = value;
  }

  setBookStyle(value){
    binding_style = value.toString();
  }

  setColor(value){
    color = value.toString();
  }

  setFileType(value){
    filetype = value.toString();
  }

  setPaperType(value){
    paper_type = value.toString();
  }

  setSide(value){
    side = value.toString();
  }

  setThickness(value){
    book_thickness = value.toString();
  }

  setAdditionalPrice(value){
    additional_price = value;
  }

  setReminder(value){
    reminder = value.toString();
  }


}

class BigPrint {
  String kind = "bigprint";
  String? size;
  int? quantity;
  int? total_page;
  String? color;
  String? paper_type;
  String? percentage;
  String? reminder;
  int price = 0;

  List size_list = ['A2','A1','A0'];
  List color_list = ['흑백','칼라'];
  List paper_type_list = ['일반지','칼라지','유포지', '인화지','캔버스지'];
  List percentage_list = ['20이하','20~50','50이상'];

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
    data['kind'] = kind;
    data['size'] = size;
    data['quantity'] = quantity;
    data['total_page'] = total_page;
    data['color'] = color;
    data['percentage'] = percentage;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  BigPrint(){
    this.size = this.size_list[0];
    this.quantity = 0;
    this.total_page = 0;
    this.color = this.color_list[0];
    this.paper_type = paper_type_list[0];
    this.percentage = percentage_list[0];
    this.reminder = "";
  }

  setSize(value){
    size = value.toString();
  }

  setQuantity(value){
    quantity = value;
  }

  setTotalPage(value){
    total_page = value;
  }

  setColor(value){
    color = value.toString();
  }

  setPaperType(value){
    paper_type = value.toString();
  }

  setPercentage(value){
    percentage = value.toString();
  }

  setReminder(value){
    reminder = value.toString();
  }

}

class OtherService{
  String kind = "otherservice";
  int? laminate;
  int? scan;
  int? staple;
  String? reminder;

  int price = 0;

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
    data['kind'] = kind;
    data['laminate'] = laminate;
    data['scan'] = scan;
    data['staple'] = staple;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }

  OtherService(){
    this.laminate = 0;
    this.scan = 0;
    this.staple = 0;
  }

  sumAll(){
    price = laminate! + scan! + staple!;
  }

  setLaminate(value){
    laminate = value;
    sumAll();
  }

  setScan(value){
    scan = value;
    sumAll();
  }

  setStaple(value){
    staple = value;
    sumAll();
  }

  setReminder(value){
    reminder = value.toString();
  }

}

class PormBoard{
  String kind = "pormboard";
  String? size;
  int? quantity;
  String? paper_type;
  String? laminate;
  String? reminder;

  int price = 0;

  List size_list = ['A4','A3','A2','A1','A0'];
  List paper_type_list = ['유포지','인화지','켈지'];
  List laminate_list = ['안함','유광','무광'];

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
    data['kind'] = kind;
    data['size'] = size;
    data['quantity'] = quantity;
    data['paper_type'] = paper_type;
    data['laminate'] = laminate;
    data['reminder'] = reminder;
    data['price'] = price;
    return data;
  }


  PormBoard(){
    this.size = this.size_list[0];
    this.quantity = 0;
    this.paper_type = paper_type_list[0];
    this.laminate = laminate_list[0];
    this.reminder = "";
  }

  setSize(value){
    size = value.toString();
  }

  setQuantity(value){
    quantity = value;
  }

  setLaminate(value){
    laminate = value.toString();
  }

  setPaperType(value){
    paper_type = value.toString();
  }

  setReminder(value){
    reminder = value.toString();
  }

}

class OffSet{
  String kind = "offset";
  NameCard? nameCard;
  Leaflet? leaflet;
  Sticker? sticker;
  Envelope? envelope;
  Banner? banner;

  OffSet(){
    this.nameCard = NameCard();
    this.leaflet = Leaflet();
    this.sticker = Sticker();
    this.envelope = Envelope();
    this.banner = Banner();
  }



}

class NameCard{
  String kind = "namecard";
  String? paper_type;
  String? side;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List paper_type_list = ['일반지','수입지'];
  List side_list = ['단면', '양면'];

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
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

  NameCard(){
    this.paper_type = paper_type_list[0];
    this.side = side_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  setPaperType(value){
    paper_type = value.toString();
  }

  setSide(value){
    side = value.toString();
  }

  setQuantity(value){
    quantity = value;
  }

  setDesignPage(value){
    design_page = value;
  }

  setAdditionalPrice(value){
    addtional_price = value;
  }

  setReminder(value){
    reminder = value.toString();
  }

}

class Leaflet{
  String kind = "leaflet";
  String? size;
  String? side;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List size_list = ['A5','B5','A4','B4','A3'];
  List side_list = ['단면', '양면'];

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
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

  Leaflet(){
    this.size = size_list[0];
    this.side = side_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  setSize(value){
    size = value.toString();
  }

  setSide(value){
    side = value.toString();
  }

  setQuantity(value){
    quantity = value;
  }

  setDesignPage(value){
    design_page = value;
  }

  setAdditionalPrice(value){
    addtional_price = value;
  }

  setReminder(value){
    reminder = value.toString();
  }

}

class Sticker{
  String kind = "sticker";
  String? paper_type;
  String? laminate;
  String? size;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List paper_type_list = ['일반지','도무송'];
  List laminate_list = ['없음', '있음'];
  List size_list = ['6cm 미만','6cm 이상','10cm 이하','10cm 이상','10 ~ 15cm','15cm 이상'];

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
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

  Sticker(){
    this.paper_type = paper_type_list[0];
    this.laminate = laminate_list[0];
    this.size = size_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  setPaperType(value){
    paper_type = value.toString();
  }

  setLaminate(value){
    laminate = value.toString();
  }

  setSize(value){
    size = value.toString();
  }


  setQuantity(value){
    quantity = value;
  }

  setDesignPage(value){
    design_page = value;
  }

  setAdditionalPrice(value){
    addtional_price = value;
  }

  setReminder(value){
    reminder = value.toString();
  }
}

class Envelope{
  String kind = "envelope";
  String? size;
  String? paper_type;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List size_list = ['소', '대'];
  List paper_type_list = ['모조 100','모조 120','줄 레자크','체크 레자크','크라프트'];

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
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

  Envelope(){
    this.size = size_list[0];
    this.paper_type = paper_type_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  setPaperType(value){
    paper_type = value.toString();
  }

  setSize(value){
    size = value.toString();
  }

  setQuantity(value){
    quantity = value;
  }

  setDesignPage(value){
    design_page = value;
  }

  setAdditionalPrice(value){
    addtional_price = value;
  }

  setReminder(value){
    reminder = value.toString();
  }
}

class Banner{
  String kind = "banner";
  String? paper_type;
  String? rests;
  int? quantity;
  int? design_page;
  int? addtional_price;
  String? reminder;
  int price = 0;

  List paper_type_list = ['기본','투명','통풍'];
  List rests_list = ['20000', '30000','40000','50000'];

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data={};
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

  Banner(){
    this.paper_type = paper_type_list[0];
    this.rests = rests_list[0];
    this.quantity = 0;
    this.design_page = 0;
    this.addtional_price = 0;
    this.reminder = "";
  }

  setPaperType(value){
    paper_type = value.toString();
  }

  setRests(value){
    rests = value.toString();
  }

  setQuantity(value){
    quantity = value;
  }

  setDesignPage(value){
    design_page = value;
  }

  setAdditionalPrice(value){
    addtional_price = value;
  }

  setReminder(value){
    reminder = value.toString();
  }
}