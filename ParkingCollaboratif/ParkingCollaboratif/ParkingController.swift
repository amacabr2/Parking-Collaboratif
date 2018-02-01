import Foundation

class ParkingController {
    
    func fetchParking(completion: @escaping(Parking?) -> Void) {
        let baseUrl = URL(string: "http://www-etu.iut-bm.univ-fcomte.fr/~amacabr2/LicencePro/ParkingAPI/Server")!
        let query: [String: String] = [
            "todo": "SELECT",
            "id": 1
        ]
        let url = baseUrl.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let rawJson = try? JSONSerialization.jsonObject(with: data),
                let json = rawJson as? [String: String],
                let parking = Parking(json: json) {
                completion(parking)
            }
        }
        
        task.resume()
    }

    func fetchAllParking(completion: @escaping([Parking]?) -> Void) {
        let baseUrl = URL(string: "http://www-etu.iut-bm.univ-fcomte.fr/~amacabr2/LicencePro/ParkingAPI/Server")!
        let query: [String: String] = [
            "todo": "ALL"
        ]
        let url = baseUrl.withQueries(query)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let rawJson = try? JSONSerialization.jsonObject(with: data),
                let json = rawJson as? [[String: String]],
                let parkingArray = json.flatMap { Parking(json: $0)}
                completion(parkingArray)
            }
        }
        
        task.resume() 
    }

    func postParking() {
        
    }
}
