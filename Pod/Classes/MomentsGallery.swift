// MomentsGallery.swift
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

@objc public protocol MomentsGalleryDelegate {
    optional func didShowMomentAtIndex(index: Int)
}

public class MomentsGallery: UIViewController, UIScrollViewDelegate {
    
    // Delegate
    weak public var delegate: MomentsGalleryDelegate?
    
    // Interface elements
    var pagingScrollView: UIScrollView!
    var progressIndicatorView: UIView!
    var progressIndicatorInnerView: UIView!
    var closeButton: UIButton!
    
    // Paging
    var currentPageIndex: Int = 0
    
    // Content
    var moments: [Moment] = []
    var innerViews: [UIView] = []
    var innerScrollViews: [UIScrollView] = []
    
    // User settings
    public var scrollViewGutter: CGFloat = 2.5
    public var scrollViewBackgroundColor: UIColor = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1)
    public var parallaxFactor: CGFloat = 0.25
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(moments: [Moment]) {
        self.init(nibName: nil, bundle: nil)
        
        self.moments = moments
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(rotatedScreen), name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func rotatedScreen() {
        pagingScrollView = nil
        setup()
    }
    
    private func setup() {
        pagingScrollView = UIScrollView(frame: view.frame)
        pagingScrollView.frame.origin.x -= scrollViewGutter
        pagingScrollView.frame.size.width += scrollViewGutter * 2
        pagingScrollView.delegate = self
        pagingScrollView.pagingEnabled = true
        pagingScrollView.showsHorizontalScrollIndicator = false
        pagingScrollView.backgroundColor = scrollViewBackgroundColor
        pagingScrollView.contentSize = CGSizeMake(pagingScrollView.frame.size.width * CGFloat(moments.count), view.frame.size.height)
        
        for var i = 0; i < moments.count; i++ {
            let moment = moments[i]
            
            let innerView = MomentView(moment: moment, frame: CGRectMake(pagingScrollView.frame.size.width * CGFloat(i) + scrollViewGutter, 0, view.frame.size.width, view.frame.size.height))
            
            pagingScrollView?.addSubview(innerView)
            innerViews.append(innerView)
            innerScrollViews.append(innerView.scrollView)
        }
        
        self.view.addSubview(pagingScrollView)
        
        
        // Setup pagingView
        progressIndicatorView = UIView(frame: CGRectMake(25, UIScreen.mainScreen().bounds.size.height - 25, UIScreen.mainScreen().bounds.size.width-50, 2))
        progressIndicatorView.backgroundColor = UIColor(white: 1, alpha: 0.21)
        progressIndicatorView.clipsToBounds = true
        
        progressIndicatorInnerView = UIView(frame: CGRectMake(0, 0, progressIndicatorView.frame.size.width / CGFloat(moments.count), progressIndicatorView.frame.size.height))
        progressIndicatorInnerView.backgroundColor = UIColor(white: 1, alpha: 1)
        progressIndicatorView.addSubview(progressIndicatorInnerView)
        
        self.view.addSubview(progressIndicatorView)
        
        // Setup close button)
        closeButton = UIButton(frame: CGRectMake(view.frame.size.width - 50, 0, 50, 50))
        closeButton.setTitle("+", forState: .Normal)
        closeButton.titleLabel!.font = UIFont.systemFontOfSize(35, weight: UIFontWeightThin)
        closeButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        closeButton.addTarget(self, action: "closeButtonTouched:", forControlEvents: .TouchUpInside)
        self.view.addSubview(closeButton)
        
        // Stage
        pagingScrollView.setContentOffset(CGPointMake(pagingScrollView.frame.size.width * CGFloat(currentPageIndex), 0), animated: false)
    }
    
    // MARK: - UIScrollView Delegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        for var i = 0; i < innerViews.count; i++ {
            innerScrollViews[i].contentOffset = CGPointMake((scrollView.contentOffset.x - innerViews[i].frame.origin.x) * -parallaxFactor, 0)
        }
        
        progressIndicatorInnerView.frame.size.width = (progressIndicatorView.frame.size.width / CGFloat(moments.count)) * ((scrollView.contentOffset.x / scrollView.frame.size.width) + 1)
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        currentPageIndex = page
        
        delegate?.didShowMomentAtIndex?(page)
    }
    
    // Close button actions
    func closeButtonTouched(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

// MARK: - Public user functions
extension MomentsGallery {
    
    public func scrollToIndex(index: Int) {
        pagingScrollView.setContentOffset(CGPointMake(pagingScrollView.frame.size.width * CGFloat(index), 0), animated: true)
    }
    
}