//
//  VTMovie.swift
//  Vault
//
//  Created by Kevin on 2023/7/20.
//

import Foundation

struct VTMovie: Codable {
    let id: String
    let name: String
    let directors: String
    let scenarists: String
    let actors: String
    let style: String
    let year: String
    let release_date: String
    let area: String
    let language: String
    let length: String
    let other_names: String
    let score: String
    let rating_number: String
    let synopsis: String
    let imdb: String
    let poster_name: String
    let filePath: String
    let fileUrl: String
    let is_downloaded: String
    let download_link: String
    let create_date: String
    let lastWatch_date: String
    let lastWatch_user: String
}
