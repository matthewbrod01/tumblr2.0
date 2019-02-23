//
//  PhotoDetailsViewController.swift
//  tumblr2.0
//
//  Created by Matthew Rodriguez on 2/21/19.
//  Copyright © 2019 Matthew Rodriguez. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetailsViewController: UIViewController {
    
    var photoUrlString: String = ""
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // When this loads, photoUrlString received a string value from our sender
        let url = URL(string: photoUrlString)
        detailImageView.af_setImage(withURL: url!)
        
        detailImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func onTapImage(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "zoomPhotoSegue", sender: UITapGestureRecognizer.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FullScreenPhotoViewController
        vc.image = detailImageView.image
    }
}
