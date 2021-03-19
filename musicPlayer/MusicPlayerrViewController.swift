
//
//  MusicPlayerViewController.swift
//  musicPlayer
//
//  Created by AbdulKadir Akkaş on 11.03.2021.
//

import UIKit

final class MusicPlayerrViewController :UIViewController {
    var album : Album
    
    
    private lazy var mediaPlayer : MediaPlayer = {
        var x = MediaPlayer(album: album)
        x.translatesAutoresizingMaskIntoConstraints = false
        return x
    }()
    
    init(album : Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBlurredView()
        setupView()
        
    }
    
    private func setupView() {
        addBlurredView()
        view.addSubview(mediaPlayer)
        setUpConstraints()
    }
    
    
    private func addBlurredView(){
        if !UIAccessibility.isReduceTransparencyEnabled{
            self.view.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleHeight , .flexibleWidth]
            view.addSubview(blurEffectView)
        }else{
            view.backgroundColor = UIColor.black
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            mediaPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mediaPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mediaPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            mediaPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mediaPlayer.play()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mediaPlayer.stop()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
}

