//
//  ViewController.swift
//  itunesClone
//
//  Created by stephen tai on 1/4/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let itunes_url_path : String = "https://itunes.apple.com/search?term=jack+johnson&entity=album"
    private var music_result : BehaviorRelay<[MusicObject]> = BehaviorRelay(value: [])
    let tbv = UITableView()
    let disposeBag =  DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "itunes clone"
        
        readUrl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func readUrl(){
        if let url = URL(string: itunes_url_path) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(URLResult.self, from: data)
//                        for music in parsedJSON.results {
//                            print(music.artistName)
//                            print(music.collectionName)
//                        }
                        self.music_result.accept(parsedJSON.results)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
}

