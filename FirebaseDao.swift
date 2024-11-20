import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift


class FirebaseDAO : ObservableObject {
    var ref = Database.database().reference()
   
    @Published
    var value: String? = nil

    @Published
    var object: RoomData? = nil

    @Published
    var listObject = [RoomData]()
    
    func readValue(){
        
        
        ref.child("").observeSingleEvent(of: .value) { snapshot in
            self.value = snapshot.value as? String
        }
    }
    func observeListObject(){
        ref.child("").observe(.value) { parentSnapshot in
            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            self.listObject = children.compactMap { snapshot in
                guard let key = Int(snapshot.key), (1...4).contains(key) else {
                    return nil // Skip 
                }
                return try? snapshot.data(as: RoomData.self)
            }
        }
    }


    
//    func observeListObject(){
//        ref.child("test").observe(.value) { parentSnapshot in
//            guard let children = parentSnapshot.children.allObjects as? [DataSnapshot] else {
//                return
//            }
//            self.listObject = children.compactMap({ snapshot in
//                return try? snapshot.data(as: RoomData.self)
//            })
//        }
//    }
}
