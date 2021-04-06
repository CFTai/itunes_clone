//
//  ItunesItem.swift
//  itunesClone
//
//  Created by stephen tai on 1/4/2021.
//

import Foundation


struct MusicObject: Codable {
    let wrapperType: String
    let collectionType: String
    let artistId: Int
    let collectionId: Int
    let amgArtistId: Int?
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String
    let artistViewUrl: String
    let collectionViewUrl: String
    let artworkUrl60: String
    let artworkUrl100: String
    let collectionPrice: Float
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String
    let country: String
    let currency: String
    let releaseDate: String
    let primaryGenreName: String
}

struct URLResult: Codable {
    let resultCount: Int
    let results: [MusicObject]
}
