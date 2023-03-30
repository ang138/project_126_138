class Room{
  String? roomnum;
  String? status;

  Room();

  Map<String, dynamic> toJson() => {'roomnum': roomnum, 'status': status};

  Room.fromSnapshot(snapshot)
    : roomnum = snapshot.data()['roomnum'],
      status = snapshot.data()['status'];


}