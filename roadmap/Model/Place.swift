//
//  Place.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/29.
//

import Foundation

struct Place:Codable {
    let courseTitle:String?
    let courseId: Int?
    let day: Int?
    let roadmapOrd: Int?
    let placeId: Int?
    let placeName: String?
    let placeCode : String?
    let placeAddr: String?
    let placePx: String?
    let placePy: String?
    let placePhoneNumber: String?
    let placeOfficeHours: String?
    let placeMcidName: String?
    let placeThumbnailUrl:String?
}
