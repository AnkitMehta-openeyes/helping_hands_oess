import 'dart:convert';

List<GetItem> getItemFromJson(String str) => List<GetItem>.from(json.decode(str).map((x) => GetItem.fromJson(x)));

String getItemToJson(List<GetItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetItem {
  GetItem({
    this.sLNo,
    this.itemName,
    this.category,
  });

  String sLNo;
  String itemName;
  String category;

  factory GetItem.fromJson(Map<String, dynamic> json) => GetItem(
    sLNo: json["S/L NO"],
    itemName: json["Item Name"] == null ? null : json["Item Name"],
    category: json["Category"] == null ? null : json["Category"],
  );

  Map<String, dynamic> toJson() => {
    "S/L NO": sLNo,
    "Item Name": itemName == null ? null : itemName,
    "Category": category == null ? null : category,
  };
}
