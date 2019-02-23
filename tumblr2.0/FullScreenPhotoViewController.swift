//
//  FullScreenPhotoViewController.swift
//  tumblr2.0
//
//  Created by Matthew Rodriguez on 2/21/19.
//  Copyright © 2019 Matthew Rodriguez. All rights reserved.
//

import UIKit

class FullScreenPhotoViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var zoomImageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        zoomImageView.image = self.image
        scrollView.contentSize = zoomImageView.image!.size
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomImageView
    }
    
    @IBAction func onTapClose(_ sender: Any) {
        dismiss(animated: false)
    }
}
