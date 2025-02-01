//
//  GifResponseModels.swift
//  Headway
//
//  Created by omar abozeid on 27/01/2025.
//

import Foundation

// Response for Trending GIFs
struct GifResponse: Decodable {
    let results: [Gif]
}

struct Gif: Decodable, Identifiable {
    let id: String
    let title: String
    let media_formats: MediaFormats
}

struct MediaFormats: Decodable {
    let tinygif: GifDetails
}

struct GifDetails: Decodable {
    let url: String
}

// Response for Categories
struct GifCategoriesResponse: Decodable {
    let tags: [GifCategory]
}

struct GifCategory: Decodable, Identifiable {
    let searchterm: String
    let path: String
    let image: String
    let name: String
    
    var id: String { searchterm }
    
}
