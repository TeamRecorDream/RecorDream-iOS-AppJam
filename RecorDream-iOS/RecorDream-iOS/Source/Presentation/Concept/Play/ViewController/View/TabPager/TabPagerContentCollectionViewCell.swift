//
//  TabPagerContentCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/20.
//

import UIKit
import AVFAudio

enum TimerStatus{
    case start
    case pause
    case end
    case replay
}

class TabPagerContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var audioPlayView: UIView!
    @IBOutlet weak var middleBarView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var audioPlayStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var audioPlayProgressView: UIProgressView!
    @IBOutlet weak var cuttentTimeLabel: UILabel!
    @IBOutlet weak var audioPlayButton: UIButton!
    @IBOutlet weak var audioReplayButton: UIButton!
    
    static let identifier = "TabPagerCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "TabPagerContentCollectionViewCell", bundle: nil)
    }
    var audioPlayer: AVAudioPlayer?
    var audioFile: URL?
    var progressTimer: DispatchSourceTimer?
    var timerStatus: TimerStatus = .end
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureAudioPlay()
    }
    
    
    func configureCell(isHidden: Bool, contents: [String]?) {
        audioPlayStackViewHeight.constant = isHidden ? 0 : self.frame.height / 5
        audioPlayView.isHidden = isHidden
        middleBarView.isHidden = isHidden
        
        guard let contents = contents else {return}
        self.contentTextView.text = isHidden ? contents.last : contents.first
    }
    
    deinit {
        progressTimer = nil
    }
}

//MARK: - AudioPlay
extension TabPagerContentCollectionViewCell {
    private func configureAudioPlay() {
        audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        audioPlayButton.setImage(ImageList.icnStop.image, for: .selected)
        audioPlayButton.backgroundColor = .clear
        initPlay()
    }
    
    private func initPlay() {
        do {
            guard let audioFile = audioFile else { return }
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("ERROR initPlayer : \(error)")
        }
        
        audioPlayProgressView.progress = 0
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
    }
    
    private func convertNSTimeInterval12String(_ time: TimeInterval) -> String {
        let minute = Int(time/60)
        let second = Int(time.truncatingRemainder(dividingBy: 60))
        let timeString = String(format: "%02d:%02d", minute, second)
        
        return timeString
    }
    
    private func setAudioPlay() {
        guard let audioPlayer = audioPlayer else { return }
        
        if self.progressTimer == nil {
            progressTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            progressTimer?.schedule(deadline: .now(), repeating: 1)
            progressTimer?.setEventHandler { [weak self] in
                guard let self = self else { return }
                self.cuttentTimeLabel.text = self.convertNSTimeInterval12String(audioPlayer.currentTime)
                self.audioPlayProgressView.progress = Float(audioPlayer.currentTime / audioPlayer.duration)
            }
        }
        timerStatus = .start
        progressTimer?.resume()
        audioPlayer.play()
    }
    
    private func setAudioPause() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.pause()
        self.progressTimer?.suspend()
    }
    
    private func setAudioStop() {
        guard let audioPlayer = audioPlayer else { return }
        
        timerStatus = .end
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressTimer?.cancel()
        progressTimer = nil
        self.cuttentTimeLabel.text = self.convertNSTimeInterval12String(0)
        self.timerStatus = .end
    }
    
    //현재 음성 재생 상태 확인
    private func checkTimerStatus() {
        switch self.timerStatus {
        case .end:
            self.timerStatus = .start
            //self.audioReplayButton.isUserInteractionEnabled = false
            self.audioPlayButton.isSelected = true
            self.setAudioPlay()
        case .start:
            self.timerStatus = .pause
            //self.audioReplayButton.isUserInteractionEnabled = true
            self.audioPlayButton.isSelected = false
            self.setAudioPause()
        case .pause:
            self.timerStatus = .start
            //self.audioReplayButton.isUserInteractionEnabled = true
            self.audioPlayButton.isSelected = true
            self.setAudioPlay()
        case .replay:
            self.audioPlayButton.isSelected = true
            setAudioStop()
            setAudioPlay()
        }
    }
    
    @IBAction func didTapAudioPlayButton(_ sender: UIButton) {
        checkTimerStatus()
    }
    
    @IBAction func didTapAudioReplayButton(_ sender: UIButton) {
        self.timerStatus = .replay
        checkTimerStatus()
    }
}

extension TabPagerContentCollectionViewCell: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //self.audioReplayButton.isUserInteractionEnabled = true
        self.audioPlayProgressView.progress = 0
        self.setAudioStop()
        self.audioPlayButton.isSelected = false
    }
}
