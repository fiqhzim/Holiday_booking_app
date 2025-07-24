//In here first we create the users json model
// To parse this JSON data, do
//
class TourBook {
  final int? bookid;
  final int? userid;
  final String bookdate;
  final String booktime;
  final String tourstartdate;
  final String tourenddate;
  final String? tourpackage;
  final int numpeople;
  final String packageprice;
  bool isEditing = false;

  TourBook({
    this.bookid,
    required this.userid,
    required this.bookdate,
    required this.booktime,
    required this.tourstartdate,
    required this.tourenddate,
    required this.tourpackage,
    required this.numpeople,
    required this.packageprice,
  });

  factory TourBook.fromMap(Map<String, dynamic> json) => TourBook(
        bookid: json["bookid"],
        userid: json["userid"],
        bookdate: json["bookdate"],
        booktime: json["booktime"],
        tourstartdate: json["tourstartdate"],
        tourenddate: json["tourenddate"],
        tourpackage: json["tourpackage"],
        numpeople: json["numpeople"],
        packageprice: json["packageprice"],
      );

  Map<String, dynamic> toMap() => {
        "bookid": bookid,
        "userid": userid,
        "bookdate": bookdate,
        "booktime": booktime,
        "tourstartdate": tourstartdate,
        "tourenddate": tourenddate,
        "tourpackage": tourpackage ?? '',
        "numpeople": numpeople,
        "packageprice": packageprice,
      };
}
