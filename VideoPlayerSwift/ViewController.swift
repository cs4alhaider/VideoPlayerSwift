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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        play()
    }
    
    /// Play a video on UIView
    fileprivate func play() {
        guard let path = Bundle.main.path(forResource: "testVid", ofType:"mp4") else {
            debugPrint("testVid.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
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
