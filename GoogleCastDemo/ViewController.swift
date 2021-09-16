//
//  ViewController.swift
//  GoogleCastDemo
//
//  Created by Sohel Rana on 16/9/21.
//

import UIKit
import GoogleCast

class ViewController: UIViewController {

    var sessionManager: GCKSessionManager!
    private var miniMediaControlsViewController: GCKUIMiniMediaControlsViewController!
    var mediaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionManager = GCKCastContext.sharedInstance().sessionManager
        
        mediaView = UIView(frame: CGRect(x: 0, y: self.view.frame.height - 30, width: self.view.frame.width, height: 70))

        self.view.addSubview(mediaView!)
        
        let castContext = GCKCastContext.sharedInstance()
        sessionManager.add(self)
        miniMediaControlsViewController = castContext.createMiniMediaControlsViewController()
        miniMediaControlsViewController.delegate = self
        updateControlBarsVisibility(shouldAppear: true)
        installViewController(miniMediaControlsViewController, inContainerView: mediaView!)
    }
    
    @IBAction func castVideo(_ sender: Any) {
        let url = URL.init(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")
//        guard let mediaURL = url else {
//                   print("invalid mediaURL")
//                   return
//                }
        let metaData = GCKMediaMetadata()
        metaData.setString("This is Descriptions", forKey: kGCKMetadataKeyTitle)
        metaData.setString("This is Descriptions", forKey: kGCKMetadataKeySubtitle)
        metaData.addImage(GCKImage(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg")!, width: 480, height: 360))
        
        let mediaInfoBuilder = GCKMediaInformationBuilder.init(contentURL: url!)
        mediaInfoBuilder.streamType = GCKMediaStreamType.none;
                mediaInfoBuilder.contentType = "video/mp4"
                mediaInfoBuilder.metadata = metaData;
                let mediaInformation = mediaInfoBuilder.build()
                // Now finally handing over all information and load video
                if let request =  sessionManager.currentSession?.remoteMediaClient?.loadMedia(mediaInformation){
                   request.delegate = self
                    
                }
        GCKCastContext.sharedInstance().presentDefaultExpandedMediaControls()
        
        
        
    }
    
    
    func installViewController(_ viewController: UIViewController?, inContainerView containerView: UIView) {
            if let viewController = viewController {
                addChild(viewController)
                viewController.view.frame = containerView.bounds
                containerView.addSubview(viewController.view)
                viewController.didMove(toParent: self)
            }
        }
    
    func updateControlBarsVisibility(shouldAppear: Bool = false) {
            if shouldAppear {
                mediaView!.isHidden = false
            } else {
    //            mediaView!.isHidden = true
            }
            UIView.animate(withDuration: 1, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
            view.setNeedsLayout()
        }

}


extension ViewController: GCKRequestDelegate {
    
}

extension ViewController: GCKUIMiniMediaControlsViewControllerDelegate {
    func miniMediaControlsViewController(_ miniMediaControlsViewController: GCKUIMiniMediaControlsViewController, shouldAppear: Bool) {
        updateControlBarsVisibility(shouldAppear: shouldAppear)
    }
}

extension ViewController: GCKSessionManagerListener {
    
}
