class PrintNBook{
  String? size;
  int? quantity;
  int? total_page;
  int? additional_price;
  String? binding_style;
  String? color;
  String? filetype;
  String? book_thickness;
  String? reminder;

  List size_list = ['A5','B5','A4','B4','A3'];
  List binding_style_list = ['Book','Ring','3 Hole', 'Staple'];
  List color_list = ['black','color'];
  List filetype_list = ['PDF','JPEG','AUTOCAD','AI'];
  List book_thickness_list = ['1~20','21~30','31~40','41~50','51~'];
  int price = 0;

  PrintNBook(){
    this.size = this.size_list[0];
    this.quantity = 0;
    this.total_page = 0;
    this.binding_style = this.binding_style_list[0];
    this.color = this.color_list[0];
    this.filetype = this.filetype_list[0];
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

  setThickness(value){
    book_thickness = value.toString();
  }

  setAdditionalPrice(value){
    additional_price = value;
  }


}

class BigPrint {
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
  List paper_type_list = ['normal','color','synthetic', 'picture','canvas'];
  List percentage_list = ['20이하','20~50','50이상'];

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

}

class OtherService{
  int? laminate;
  int? scan;
  int? staple;
  String? reminder;

  int price = 0;

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

}

class PormBoard{
  String? size;
  int? quantity;
  String? paper_type;
  String? laminate;
  String? reminder;

  List size_list = ['A4','A3','A2','A1','A0'];
  List paper_type_list = ['synthetic','picture','kel'];
  List laminate_list = ['no','glaze','matte'];

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


}