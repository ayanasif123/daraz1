class NoteModel {
  int? id;
  String title;
  String note;
  String date;

  NoteModel({this.id, required this.title, required this.note, required this.date});

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
        id: map['id'],
        title: map['title'],
        note: map['note'],
        date: map['date'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'note': note,
        'date': date,
      };
}
