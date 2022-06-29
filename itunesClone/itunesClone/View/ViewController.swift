//
//  ViewController.swift
//  itunesClone
//
//  Created by stephen tai on 1/4/2021.
//

import UIKit

class ViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private let itunes_url_path : String = "https://itunes.apple.com/search?term=jack+johnson&entity=album"
    var music_list = MusicList()
    var bookmark_list = BookmarkList()
    var collectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        music_list.addObservers(observers: bookmark_list)
        createView()
        readUrl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Itunes clone"
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let rightButton = UIBarButtonItem(
            title:String(format: "Bookmark: %i", bookmark_list.song_list.count),
            style:.plain,
            target:self,
            action:#selector(ViewController.bookmark))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func createView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
    }
    
    
    func readUrl(){
        if let url = URL(string: itunes_url_path) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let parsedJSON = try jsonDecoder.decode(URLResult.self, from: data)
                        self.music_list.song_list = parsedJSON.results
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.music_list.song_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        let item_image = URL(string: switchToLargeImage(path: self.music_list.song_list[indexPath.row].artworkUrl60))
        let data = try? Data(contentsOf: item_image!)
        if(UIImage(data: data!) != nil){
            cell.bg_iv.image = UIImage(data: data!)!
        } else {
            cell.bg_iv.image = UIImage(named: "DefaultImage")!
        }
        cell.collection_lb.text = self.music_list.song_list[indexPath.row].collectionName
        return cell
    }
    
    // Setup item per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 1
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.music_list.addCollectionToObserver(obj: self.music_list.song_list[indexPath.row])
        self.navigationItem.rightBarButtonItem?.title = String(format: "Bookmark: %i", bookmark_list.song_list.count)
    }
    
    func switchToLargeImage(path url:String) -> String {
        return url.replacingOccurrences(of: "60x60", with: "600x600")
    }
    
    @objc func bookmark() {
        let bvc = BookmarkViewController()
        bvc.setList(MusicList: bookmark_list.song_list)
        self.navigationController?.pushViewController(
            bvc, animated: true)
    }
    
}
