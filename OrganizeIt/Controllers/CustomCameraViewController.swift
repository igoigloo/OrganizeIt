//
//  CustomCameraViewController.swift
//  OrganizeIt
//
//  Created by Jose Domingo on 2018-08-05.
//  Copyright © 2018 Jose Domingo. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class CustomCameraViewController: UIViewController{
    lazy var vision = Vision.vision()
    
    @IBOutlet weak var cameraButton: UIButton!
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    var selectedLabelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.borderWidth = 5
        cameraButton.clipsToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
//        photoOutput?.capturePhoto(with: settings, delegate: self)
        photoOutput?.capturePhoto(with: settings, delegate: self)
        // performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! PreviewViewController
            previewVC.image = self.image
            previewVC.labelText = self.selectedLabelText!
            
        }
    }
}

extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            if let image = image {
                let labelDetector = vision.labelDetector()
                let visionImage = VisionImage(image: image)
                
                labelDetector.detect(in: visionImage) { features, error in
                    guard error == nil, let features = features, !features.isEmpty else {
                        return
                    }
                    
//                    var currentConfidence: Float = 0.0
                    self.selectedLabelText = features[0].label
//                    for feature in features {
//                        let labelText = feature.label
//                        let entityId = feature.entityID
//                        let confidence = feature.confidence
//
//                        if currentConfidence < confidence {
//                            currentConfidence = confidence
//                            self.selectedLabelText = labelText
//                        }
//
//                    }
                    
                    self.performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
                    
                    
            
                }
            }
            
        }
    }
}

