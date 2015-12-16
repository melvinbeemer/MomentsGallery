// MomentScrollView.swift
//
// Copyright (c) 2015 Fortyfox <melvin@fortyfox.co>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

class MomentScrollView: UIScrollView, UIScrollViewDelegate {
    
    var moment: Moment!
    var imageView: MomentImageView!
    
    var minScale: CGFloat = 1
    var maxScale: CGFloat = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(moment: Moment, frame: CGRect) {
        self.init(frame: frame)
        
        self.moment = moment
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentSize = self.frame.size
        self.delegate = self
        self.bounces = false
        self.scrollEnabled = false
        
        if moment.url != nil {
            imageView = MomentImageView(url: moment.url, frame: CGRectMake(0, 0, self.frame.size.width+1, self.frame.size.height))
        } else {
            imageView = MomentImageView(image: moment.image, frame: CGRectMake(0, 0, self.frame.size.width+1, self.frame.size.height))
        }
        
        self.addSubview(imageView)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewTapped")
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapRecognizer)
    }
    
    func scrollViewTapped() {
        if imageView.contentMode == UIViewContentMode.ScaleAspectFit {
            imageView.animateImageView(.ScaleAspectFill)
        } else {
            imageView.animateImageView(.ScaleAspectFit)
        }
    }
}
