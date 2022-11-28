//
//  Course.swift
//  roadmap
//
//  Created by Terry on 2022/11/25.
//

import Foundation

struct Course:Codable {
    let courseId: Int
    let courseTitle: String
    let courseThumbnailUrl: String
    let regDt: String
    let chgDt: String 
}
