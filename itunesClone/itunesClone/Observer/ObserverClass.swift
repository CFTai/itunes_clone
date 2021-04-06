//
//  ObserverClass.swift
//  itunesClone
//
//  Created by stephen tai on 1/4/2021.
//

import Foundation

protocol Observer:class {
    func notify(item:String)
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
    func sendNotifications(item:String) {
        for observer in observers {
            observer.notify(item: item)
        }
    }
}

class MusicList: SubjectBase{
    var song_list : [MusicObject] = []
    
    func addToBookMark(item:String){
        sendNotifications(item: item)
    }
}

class BookmarkList:Observer {
    
    var song_list : [MusicObject] = []
    func notify(item: String) {
        ItemAddedToBookmark(item: item)
    }
    func ItemAddedToBookmark(item:String) {
        print("Item add to BookMark \(item)")
    }
}

