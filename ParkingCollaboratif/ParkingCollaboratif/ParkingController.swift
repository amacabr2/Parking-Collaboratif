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
                let json = rawJson as? [[String: String]] {
                    let parkingArray = json.flatMap { Parking(json: $0)}
                    completion(parkingArray)
            }
        }
        
        task.resume() 
    }

    func postParking(parking: Parking, completion: @escaping([Parking]?) -> Void) {
        let url =  URL(string: "http://www-etu.iut-bm.univ-fcomte.fr/~amacabr2/LicencePro/ParkingAPI/Server")!
        let postString = "method=POST&prix_horaire=\(parking.prixHoraire)&surveille=\(parking.surveille)&souterrain=\(parking.souterrain)&disponible=\(parking.disponible)&adresse=\(parking.adresse)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(response)
        }

        task.resume()
    }

    func useParking(idParking: Int, disponible: Bool, completion: @escaping(String?) -> Void) {
        let url =  URL(string: "http://www-etu.iut-bm.univ-fcomte.fr/~amacabr2/LicencePro/ParkingAPI/Server")!
        let postString = "method=DISPO&idParking=\(idParking)&disponible=\(disponible)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(response)
        }

        task.resume()
    }

    func deleteParking(idParking: Int, @escaping(String?) -> Void {
        let url =  URL(string: "http://www-etu.iut-bm.univ-fcomte.fr/~amacabr2/LicencePro/ParkingAPI/Server")!
        let postString = "method=DELETE&idParking=\(idParking)"

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(response)
        }

        task.resume()
    }
}
