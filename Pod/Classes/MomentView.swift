// MomentView.swift
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

class MomentView: UIView {
    
    var scrollView: UIScrollView!
    var moment: Moment!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(moment: Moment, frame: CGRect) {
        self.init(frame: frame)
        
        self.moment = moment
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        scrollView = MomentScrollView(moment: moment, frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        self.addSubview(scrollView)
        
        if moment.title != nil || moment.text != nil {
            let opacityView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
            opacityView.backgroundColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 0.25)
            opacityView.userInteractionEnabled = false
            self.addSubview(opacityView)
        }
        
        if moment.title != nil {
            let titleLabel = UILabel(frame: CGRectMake(25, UIScreen.mainScreen().bounds.size.height - 74, UIScreen.mainScreen().bounds.size.width - 50, 15))
            titleLabel.font = UIFont.systemFontOfSize(13, weight: UIFontWeightSemibold)
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.text = moment.title
            self.addSubview(titleLabel)
        }
        
        if moment.text != nil {
            let textLabel = UILabel(frame: CGRectMake(25, UIScreen.mainScreen().bounds.size.height - 55, UIScreen.mainScreen().bounds.size.width - 50, 15))
            textLabel.font = UIFont.systemFontOfSize(12, weight: UIFontWeightRegular)
            textLabel.textColor = UIColor.whiteColor()
            textLabel.text = moment.text
            self.addSubview(textLabel)
        }
        
    }
    
}
