//
//  AlbumTableViewCell.swift
//  musicPlayer
//
//  Created by AbdulKadir Akkaş on 8.03.2021.
//

import UIKit

final class AlbumTableViewCell : UITableViewCell {

    var album : Album? {
        didSet{
            if let album = album{
                albumCover.image = UIImage(named: album.image)
                albumName.text = album.name
                songsCount.text = "\(album.songs.count) Müzik" 
            }
        }
    }
    private lazy var albumCover : UIImageView  = {
        let x = UIImageView()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.contentMode = .scaleAspectFill
        x.clipsToBounds = true
        x.layer.cornerRadius = 25
        x.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMaxYCorner]
        return x
    }()
    
    
    private lazy var albumName : UILabel = {
       let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
       x.font = UIFont.systemFont(ofSize: 18, weight: .bold)
       x.textColor = UIColor(named: "titleColor")
        return x
    }()
    
    
    private lazy var songsCount : UILabel = {
       let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        x.textColor = .darkGray
        x.numberOfLines = 0
        x.textColor = UIColor(named: "subTitleColor")
        return x
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView(){
        [albumCover , albumName , songsCount].forEach { (x) in
            contentView.addSubview(x)
        }
       setupConstraints()
    }
    
    private func setupConstraints(){
        //Album Cover
        
        NSLayoutConstraint.activate([
            albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            albumCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumCover.widthAnchor.constraint(equalToConstant: 100),
            albumCover.heightAnchor.constraint(equalToConstant: 100),
            albumCover.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
        //AlbumName
        
        NSLayoutConstraint.activate([
            albumName.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16),
            albumName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        
        //songs count
        NSLayoutConstraint.activate([
            songsCount.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16),
            songsCount.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 8),
            songsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            songsCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
    }
}

