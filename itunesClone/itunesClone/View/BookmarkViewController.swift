//
//  BookmarkViewController.swift
//  itunesClone
//
//  Created by Stephen Tai on 6/4/2021.
//

import UIKit

class BookmarkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var bookmark_list : [MusicObject] = []
    var tb_view = UITableView()
    var safeArea: UILayoutGuide!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    func setupView(){
        self.title = "Bookmark"
        
        self.view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        tb_view.dataSource = self
        tb_view.delegate = self
        tb_view.register(UITableViewCell.self, forCellReuseIdentifier: "TBViewCellID")
        self.view.addSubview(tb_view)
        tb_view.translatesAutoresizingMaskIntoConstraints = false
        tb_view.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tb_view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tb_view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tb_view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    }
    
    func setList(MusicList objs : [MusicObject]){
        self.bookmark_list = objs
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmark_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TBViewCellID", for: indexPath)
        cell.textLabel?.text = self.bookmark_list[indexPath.row].collectionName
        return cell
    }
    
}
