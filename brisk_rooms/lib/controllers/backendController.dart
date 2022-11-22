import 'package:brisk_rooms/controllers/roomController.dart';
import 'package:brisk_rooms/models/roomModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final _roomCtr = Get.put(roomController());
final _firestore = FirebaseFirestore.instance;

class backendController extends GetxController {
  Future<void> createRoomInst(String _name, String _pass) async {
    final roomData = roomModel(
        password: _pass,
        roomName: _name,
        timeStamp: DateTime.now().toIso8601String());
    _roomCtr.setRoomData(roomData);
    await _firestore.doc("rooms/$_name").set(roomData.toMap());
    //_roomCtr.setRoomData(roomData);
    //update();
  }

  Future<dynamic> joinRoomInst(String _name, String _pass) async {
    final roomData = await _firestore.doc("rooms/$_name").get();
    final roomInst = roomModel.fromMap(roomData.data()!);
    _roomCtr.setRoomData(roomInst);
    if (roomData.exists) {
      bool isTrue = (roomInst.password == _pass);
      return isTrue;
    }
    return ('No such room has been created');
    //update();
  }
}
