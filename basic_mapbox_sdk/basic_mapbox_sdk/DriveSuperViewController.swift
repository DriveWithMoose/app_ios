//
//  DriverSuperViewController.swift
//  basic_mapbox_sdk
//
//  Created by Rajen Dey on 10/21/21.
//

import UIKit
import MapboxVision

class DriveSuperViewController: UIViewController {
    let replay = false
    
    private var driveViewController: DriveViewController!
    private var cameraVideoSource: CameraVideoSource?
    private var visionManager: VisionManager?
    private var visionReplayManager: VisionReplayManager?
    
    
    @IBOutlet weak var endDriveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (replay) {
            self.setupReplayManager()
            self.driveViewController = DriveViewController(visionReplayManager: self.visionReplayManager!)
            self.visionReplayManager!.delegate = self.driveViewController
            self.visionReplayManager!.start()
        } else {
            self.setupVisionManager()
            self.driveViewController = DriveViewController(visionManager: self.visionManager!)
            self.visionManager!.delegate = self.driveViewController
            self.visionManager!.start()
        }
        self.add(self.driveViewController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupEndDriveButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.driveViewController.remove() // need to destroy visionSafetyManager before visionManager
        self.cameraVideoSource?.stop()
        self.visionManager?.stop()
        self.visionManager?.destroy()
        self.visionReplayManager?.stop()
        self.visionReplayManager?.destroy()
    }
    
    private func setupReplayManager() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/driving_data/"
        guard let visionReplayManager = try? VisionReplayManager.create(recordPath: path) else {
            fatalError("\(path) doesn't exist")
        }
        self.visionReplayManager = visionReplayManager
    }
    
    private func setupVisionManager() {
        self.cameraVideoSource = CameraVideoSource()
        self.visionManager = VisionManager.create(videoSource: self.cameraVideoSource!)
        self.cameraVideoSource!.start()
    }
    
    private func setupEndDriveButton() {
        self.view.addSubview(self.endDriveButton)
    }

}
