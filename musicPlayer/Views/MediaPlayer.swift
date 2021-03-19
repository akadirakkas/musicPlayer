//
//  MediaPlayer.swift
//  musicPlayer
//
//  Created by AbdulKadir Akkaş on 10.03.2021.
//

import UIKit
import AVKit
final class MediaPlayer : UIView {
    var album : Album
    private lazy var albumName: UILabel  = {
       let x  = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.textAlignment = .center
        x.font = .systemFont(ofSize: 32, weight: .bold)
        return x
    }()
    
    private lazy var albumCover : UIImageView  = {
      let x = UIImageView()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.contentMode = .scaleAspectFill
        x.clipsToBounds = true
        x.layer.cornerRadius = 100
        x.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        return x
    }()
    private lazy var progressBar : UISlider  = {
       let x = UISlider()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
        x.minimumTrackTintColor = UIColor(named: "subTitleColor")
        return x
    }()
    
    private lazy var elapsedTimeLabel : UILabel = {
       let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.font = .systemFont(ofSize: 14 , weight: .light)
        x.text = "00:00"
        return x
    }()
    private lazy var remainingTimeLabel : UILabel = {
       let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.font = .systemFont(ofSize: 14 , weight: .light)
        x.text = "00:00"
        return x
    }()
    private lazy var songNameLabel : UILabel = {
       let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.font = .systemFont(ofSize: 16 , weight: .bold)
        return x
    }()
    private lazy var artistNameLabel : UILabel = {
       let x = UILabel()
        x.translatesAutoresizingMaskIntoConstraints = false
        x.font = .systemFont(ofSize: 16 , weight: .light)
        return x
    }()
    private lazy var previousButton : UIButton = {
        let x  = UIButton()
        x.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        x.setImage(UIImage(systemName: "backward.end.fill" , withConfiguration: config), for: .normal)
        x.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)
        x.tintColor = .white
        return x
    }()
    private lazy var playPauseButton : UIButton = {
        let x  = UIButton()
        x.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        x.setImage(UIImage(systemName: "play.circle.fill" , withConfiguration: config), for: .normal)
        x.addTarget(self, action: #selector(didTapplayPause(_:)), for: .touchUpInside)
        x.tintColor = .white
        return x
    }()
    private lazy var nextButton : UIButton = {
        let x  = UIButton()
        x.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        x.setImage(UIImage(systemName: "forward.end.fill" , withConfiguration: config), for: .normal)
        x.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)
        x.tintColor = .white
        return x
    }()
    private lazy var controlStack : UIStackView = {
       let x = UIStackView(arrangedSubviews: [previousButton , playPauseButton , nextButton])
        x.translatesAutoresizingMaskIntoConstraints = false
        x.axis = .horizontal
        x.distribution = .equalSpacing
        x.spacing = 10
        
        
        
        
        return x
    }()
    
    
    
    private var player = AVAudioPlayer()
    private var timer : Timer?
    private var playingIndex = 0
    
    
    init(album : Album) {
        self.album = album
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        albumName.text = album.name
        albumCover.image = UIImage(named: album.image)
        setupPlayer(song: album.songs[playingIndex])
        [ albumName , songNameLabel , artistNameLabel , elapsedTimeLabel , remainingTimeLabel ].forEach { (x) in
            x.textColor = .white
        }
        
        [albumCover , albumName , songNameLabel ,artistNameLabel , progressBar , elapsedTimeLabel ,remainingTimeLabel ,controlStack].forEach { (x) in
            addSubview(x)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        //album name
        NSLayoutConstraint.activate([
            albumName.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumName.trailingAnchor.constraint(equalTo: trailingAnchor),
            albumName.topAnchor.constraint(equalTo: topAnchor , constant: 16)
        ])
        
        //album Cover
        
        
        NSLayoutConstraint.activate([
            albumCover.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16),
            albumCover.trailingAnchor.constraint(equalTo: trailingAnchor , constant: 16),
            albumCover.topAnchor.constraint(equalTo: albumName.bottomAnchor , constant: 32),
            albumCover.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.5)
        
        ])
        
        //song name
        NSLayoutConstraint.activate([
            songNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16),
            songNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -16),
            songNameLabel.topAnchor.constraint(equalTo: albumCover.bottomAnchor , constant: 16)
        
        ])
        //artist label
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16),
            artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -16),
            artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor , constant: 8)
        
        ])
        
        
        //progress Bar
        NSLayoutConstraint.activate([
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -16),
            progressBar.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor , constant: 8)
           
        ])
        
        //elapsed time
        
        NSLayoutConstraint.activate([
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 16),
            elapsedTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor , constant: 8)
        
        ])
        
        //remaning time
        
        NSLayoutConstraint.activate([
            remainingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -16),
            remainingTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor , constant: 8)
        
        ])
        
        //Control stack
        NSLayoutConstraint.activate([
            controlStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            controlStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            controlStack.topAnchor.constraint(equalTo: remainingTimeLabel.bottomAnchor, constant: 8)
            
        ])
        
        
    }
    
    private func setupPlayer (song : Song){
        
        
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            return
        }
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
            
        }
        
        
        songNameLabel.text = song.name
        artistNameLabel.text = song.artist
        
        
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.prepareToPlay()
            
            
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
        }catch let error {
            print(error.localizedDescription)
        }
        
        
    }
    
    
    
    func play() {
        progressBar.value = 0.0
        progressBar.maximumValue = Float(player.duration)
        player.play()
        playPauseIcon(isPlaying: player.isPlaying)
        
    }
    
    private func playPauseIcon(isPlaying : Bool){
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill" , withConfiguration: config), for: .normal)
    }
    
    func stop() {
        player.stop()
        timer?.invalidate()
        timer = nil
    }
    
    
    
    @objc private func updateProgress(){
        progressBar.value = Float(player.currentTime)
        elapsedTimeLabel.text = getFormattedTime(timeInterval: player.currentTime)
        let remainingTime = player.duration - player.currentTime
        remainingTimeLabel.text = getFormattedTime(timeInterval: remainingTime)
        
    }
    
  
    
    @objc private func progressScrubbed(_ sender :UISlider){
        player.currentTime = Float64(sender.value)
    }
    
    @objc private func didTapPrevious(_ sender :UIButton){
        playingIndex -= 1
        if playingIndex < 0 {
            playingIndex = album.songs.count - 1
        }
        setupPlayer(song: album.songs[playingIndex])
        player.play()
        playPauseIcon(isPlaying: player.isPlaying)
        
    }
    
    @objc private func didTapplayPause(_ sender :UIButton){
        if player.isPlaying {
            player.pause()
        }else{
            player.play()
        }
        playPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc private func didTapNext(_ sender :UIButton){
        playingIndex += 1
        if playingIndex >= album.songs.count {
            playingIndex = 0
        }
        setupPlayer(song: album.songs[playingIndex])
        player.play()
        playPauseIcon(isPlaying: player.isPlaying)
        
    }
    
    private func getFormattedTime(timeInterval : TimeInterval) -> String{
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minsString = timeFormatter.string(from: NSNumber(value : mins)) , let secsStr = timeFormatter.string(from: NSNumber(value : secs)) else {
            return  "00:00"
        }
        return "\(minsString):\(secsStr)"
    }
}




extension MediaPlayer : AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        didTapNext(nextButton)
    }
    
    
    
}
