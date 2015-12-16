//
//  MomentImageView.swift
//  Pods
//
//  Created by Melvin Beemer on 11/22/15.
//
//

import UIKit
import Haneke

class MomentImageView: UIView {
    
    var image: UIImage!
    var url: String!
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(image: UIImage, frame: CGRect) {
        self.init(frame: frame)
        
        commonInit()
        
        self.image = image
        self.imageView.image = image
    }
    
    convenience init(url: String, frame: CGRect) {
        self.init(frame: frame)
        
        commonInit()
        
        self.url = url
        self.imageView.hnk_setImageFromURL(NSURL(string: url)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.clipsToBounds = true
        self.contentMode = UIViewContentMode.ScaleAspectFill
        
        if imageView == nil {
            imageView = UIImageView(frame: self.frame)
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.backgroundColor = UIColor.darkGrayColor()
            self.addSubview(imageView)
        }
    }
    
    func presentationImageSize() -> CGSize {
        return imageView.bounds.size
    }
    
    private func updateView() {
        if self.bounds.size.width == 0 || self.bounds.size.height == 0 {
            return
        }
        
        switch self.contentMode {
        case .ScaleAspectFit:
            updateViewToAspectFit()
            break
        case .ScaleAspectFill:
            updateViewToAspectFill()
            break
        default:
            break
        }
    }
    
    private func updateViewToAspectFit() {
        var imageSize = CGSizeMake(imageView.image!.size.width / imageView.image!.scale, imageView.image!.size.height / imageView.image!.scale)
        
        let widthRatio = imageSize.width / self.bounds.size.width
        let heightRatio = imageSize.height / self.bounds.size.height
        let imageScaleRatio = max(widthRatio, heightRatio)
        
        imageSize = CGSizeMake(imageSize.width / imageScaleRatio, imageSize.height / imageScaleRatio)
        
        imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height)
        centerImageViewToSuperView()
    }
    
    private func updateViewToAspectFill() {
        var imageSize = CGSizeMake(imageView.image!.size.width / imageView.image!.scale, imageView.image!.size.height / imageView.image!.scale)
        
        let widthRatio = imageSize.width / self.bounds.size.width
        let heightRatio = imageSize.height / self.bounds.size.height
        let imageScaleRatio = min(widthRatio, heightRatio)
        
        imageSize = CGSizeMake(imageSize.width / imageScaleRatio, imageSize.height / imageScaleRatio)
        
        imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height)
        centerImageViewToSuperView()
    }
    
    // MARK: - Helper Methods
    private func centerImageViewToSuperView() {
        imageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
    }
}

extension MomentImageView {
    
    func animateImageView(contentMode: UIViewContentMode) {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.contentMode = contentMode
            self.updateView()
            }, completion: nil)
    }
    
}
