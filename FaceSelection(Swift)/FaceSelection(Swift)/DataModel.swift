//
//  DataModel.swift
//  FaceSelection(Swift)
//
//  Created by M. on 5/18/18.
//

import Foundation

struct PhotoData: Decodable {
    let faceId: String
    let faceRectangle: FaceRectangle
}

struct FaceRectangle: Decodable {
    var top: Int
    var left: Int
    var width: Int
    var height: Int
}
