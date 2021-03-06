//
//  ViewController.swift
//  musicPlayer
//
//  Created by AbdulKadir Akkaş on 8.03.2021.
//

import UIKit
class ViewController: UIViewController {
   private let albums = Album.get()
    
    private lazy var  tableView : UITableView = {
        let x = UITableView()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.delegate = self
        x.dataSource = self
        x.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
        x.estimatedRowHeight = 132
        x.tableFooterView = UIView()
        return x
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
            
            
        
    }
  
    private func setupView() {
        title = "Müzik Uygulaması"
        view.addSubview(tableView)
        
        setupConstraints()
    }
    private func setupConstraints(){
    //TAbleView Constraints
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                
        ])
    }
}




extension ViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell
        else{
            return UITableViewCell()
        }
        cell.album = albums[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MusicPlayerrViewController(album: albums[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        present(vc, animated: true, completion: nil)
        
    }
}
