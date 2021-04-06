//
//  ObserverClass.swift
//  itunesClone
//
//  Created by stephen tai on 1/4/2021.
//

import Foundation

protocol Observer:class {
    func addCollection(Song obj: MusicObject)
}
 
protocol Subject {
    func addObservers(observers:Observer...)
    func removeObserver(observer:Observer)
}

class SubjectBase: Subject {
    private var observers = [Observer]()
    func addObservers(observers:Observer ...) {
        for item in observers {
            self.observers.append(item)
        }
    }
    func removeObserver(observer:Observer) {
        self.observers = self.observers.filter{ $0 !== observer }
    }
    
    func addCollectionToObserver(obj: MusicObject){
        for observer in observers {
            observer.addCollection(Song: obj)
        }
    }
}

class MusicList: SubjectBase{
    var song_list : [MusicObject] = []
    
}

class BookmarkList:Observer {
    var song_list : [MusicObject] = []
    func addCollection(Song obj: MusicObject) {
        addCollectionToObserver(Song: obj)
    }
    
    func addCollectionToObserver(Song obj: MusicObject) {
        if let index = song_list.firstIndex(where: {$0.collectionId == obj.collectionId}) {
            song_list.remove(at: index)
        } else {
            song_list.append(obj)
        }
    }
}


