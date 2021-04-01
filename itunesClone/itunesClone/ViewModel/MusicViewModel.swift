//
//  MusicViewModel.swift
//  itunesClone
//
//  Created by stephen tai on 1/4/2021.
//

import Foundation
import RxSwift
import RxCocoa

class MusicViewModel{
    let items = PublishSubject<[MusicObject]>()
    private let itunes_url_path : String = "https://itunes.apple.com/search?term=jack+johnson&entity=album"
    
    func fetchMusicList() {
        
            if let url = URL(string: self.itunes_url_path) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let parsedJSON = try jsonDecoder.decode(URLResult.self, from: data)
                            self.items.onNext(parsedJSON.results)
                            self.items.onCompleted()
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
            }
    }
}
