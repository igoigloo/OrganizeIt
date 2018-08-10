//
//  PreviewViewController.swift
//  OrganizeIt
//
//  Created by Jose Domingo on 2018-08-06.
//  Copyright © 2018 Jose Domingo. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var recognizedItemLabel: UILabel!
    
    var image: UIImage!
    var labelText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recognizedItemLabel.text = labelText
        photo.image = self.image
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelButton_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton_TouchUpInside(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToPVC(segue:UIStoryboardSegue) { }

}
