//
//  MapPoint.swift
//  autoService
//
//  Created by Jahongir Anvarov on 11.12.2023.
//

import Foundation

struct MapPoint {
    var title: PointInfo
    var point: Point
    let id: String
    
    init(dictionary: [String: Any]) {
        self.title = PointInfo(name: dictionary["name"] as! String, description: dictionary["description"] as! String)
        self.point = Point(latitude: dictionary["latitude"] as! Double, longitude: dictionary["longitude"] as! Double)
        self.id = dictionary["id"] as! String
    }
    
    init(title: PointInfo, point: Point) {
        self.title = title
        self.point = point
        self.id = ""
    }
    
    func toJson() -> [String: Any] {
        return ["name": title.name,
                "description": title.description,
                "latitude": point.latitude,
                "longitude": point.longitude] as [String : Any]
    }
}
