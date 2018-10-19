//
//  ViewController.swift
//  VideoPlayerSwift
//
//  Created by Abdullah on 20/10/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var avPlayer: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //play()
        playOptionTwo()
    }
    
    /// Play a video on UIView
    fileprivate func play() {
        guard let path = Bundle.main.path(forResource: "testVid", ofType:"mp4") else {
            debugPrint("testVid.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.actionAtItemEnd = .none
        
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
        view.addSubview(playerController.view)
        playerController.view.frame = view.bounds
        playerController.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerController.showsPlaybackControls = false
        playerController.player?.play()
        loopVideo(videoPlayer: player)
    }
    
    fileprivate func playOptionTwo() {
        
        guard let path = Bundle.main.path(forResource: "testVid", ofType:"mp4") else {
            debugPrint("testVid.mp4 not found")
            return
        }
        
        avPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        avPlayer.actionAtItemEnd = .none
        
        let videoLayer = AVPlayerLayer(player: avPlayer)
        videoLayer.frame = view.bounds
        videoLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(videoLayer)
        
        avPlayer.play()
        loopVideo(videoPlayer: avPlayer)
    }

    
    /// Making the video non-stop
    ///
    /// - Parameter videoPlayer: AVPlyer object
    func loopVideo(videoPlayer: AVPlayer) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            videoPlayer.seek(to: CMTime.zero)
            videoPlayer.play()
        }
    }
}
