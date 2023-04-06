// class CartEntities {
//   int id;
//   String title;
//   String image;
//   int price;
//   int count;
//
//   CartEntities({
//     required this.id,
//     required this.title,
//     required this.image,
//     required this.price,
//     required this.count,
//   });
//
//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'title': title,
//         'isCompleted': isCompleted ? 1 : 0,
//       };
//
//   factory CartEntities.fromMap(Map<String, dynamic> map) => CartEntities(
//         id: map['id'],
//         title: map['title'],
//         isCompleted: map['isCompleted'] == 1,
//       );
// }
