//
//  CameraController.swift
//  Appareil photo 2
//
//  Created by TRAORE Lionel on 8/13/19.
//  Copyright © 2019 TRAORE Lionel. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {

    @IBOutlet weak var cameraVue: UIView!
    
    var captureSession: AVCaptureSession?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var position = AVCaptureDevice.Position.back
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    func setupCamera() {
        previewLayer?.removeFromSuperlayer()
        captureSession = AVCaptureSession()
        guard captureSession != nil else { return }
        guard let appareil = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: position) else { return }
        
            do {
                let input = try AVCaptureDeviceInput(device: appareil)
                
                if captureSession!.canAddInput(input) {
                    captureSession!.addInput(input)
                    
                    capturePhotoOutput = AVCapturePhotoOutput()
                    guard capturePhotoOutput != nil else { return }
                    
                    if captureSession!.canAddOutput(capturePhotoOutput!) {
                        captureSession!.addOutput(capturePhotoOutput!)
                        
                        //Montrer notre previewLayer
                        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                        previewLayer?.videoGravity = .resizeAspectFill
                        previewLayer?.connection?.videoOrientation = .portrait
                        previewLayer?.frame = cameraVue.bounds
                        
                        guard previewLayer != nil else { return }
                        cameraVue.layer.addSublayer(previewLayer!)
                        captureSession!.startRunning()
                    }
                }
                
            } catch {
                print("Erreur -> \(error.localizedDescription)")
            }
        }
    
    @IBAction func prendrePhoto(_ sender: Any) {
        setupCamera()
    }
    
    @IBAction func versLibrary(_ sender: Any) {
     
    }
    
    @IBAction func rotateCamera(_ sender: Any) {
        switch position {
        case .back: position = .front
        default: position = .back
        }
    }
    
}
