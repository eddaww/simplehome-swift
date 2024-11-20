import Foundation

class RoomData: Encodable, Decodable, Hashable {
    var Count: Int = 0
    var Humidity: Double = 0.0
    var ID: Int = 0
    var Temperature: Double = 0.0
    
    static func == (lhs: RoomData, rhs: RoomData) -> Bool {
        return lhs.Count == rhs.Count &&
            lhs.Humidity == rhs.Humidity &&
            lhs.ID == rhs.ID &&
            lhs.Temperature == rhs.Temperature
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(Count)
        hasher.combine(Humidity)
        hasher.combine(ID)
        hasher.combine(Temperature)
    }
}

extension Encodable{
    var toDicionary:[String:Any]?{
        guard let data = try? JSONEncoder().encode(self)else{
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}

