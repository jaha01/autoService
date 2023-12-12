//
//  MapPoint.swift
//  autoService
//
//  Created by Jahongir Anvarov on 11.12.2023.
//

import Foundation

struct MapPoint {
    var title: PointTitle
    var point: Point
    
    init(dictionary: [String: Any]) {
        self.title = PointTitle(name: dictionary["name"] as! String, description: dictionary["description"] as! String)
        self.point = Point(latitude: dictionary["latitude"] as! Double, longitude: dictionary["longitude"] as! Double)
    }
    
    init(title: PointTitle, point: Point) {
        self.title = title
        self.point = point
    }
}
