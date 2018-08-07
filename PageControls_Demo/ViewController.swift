//
//  ViewController.swift
//  PageControls_Demo
//
//  Created by fashion on 2018/4/12.
//  Copyright © 2018年 shangZhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pageControl: PageControl!
    @IBOutlet weak var snakePageControl: SnakePageControl!
    @IBOutlet weak var filledPageControl: FilledPageControl!
    @IBOutlet weak var pillPageControl: PillPageControl!
    @IBOutlet weak var scrollingPageControl: ScrollingPageControl!
    
//    var pageC = ScrollingPageControl()
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        pageControl.addTarget(self, action: #selector(pageControlDidChangeCurrentPage(_:)), for: .valueChanged)
 
        
//        pageC.frame = CGRect.init(x: 0, y: 30, width: view.bounds.width, height: 20)
//        pageC.pageCount = 3
//        self.view.insertSubview(pageC, aboveSubview: self.scrollView)
        
    }
    @objc func pageControlDidChangeCurrentPage(_ pageControl: PageControl) {
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(pageControl.currentPage), y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update scroll view content size.
        let contentSize = CGSize(width: scrollView.bounds.width * 3,
                                 height: scrollView.bounds.height)
        scrollView.contentSize = contentSize
        
       // scrollingPageControl.pageCount = 3
        pageControl.numberOfPages = Int(scrollView.contentSize.width / scrollView.bounds.width)
    }
}


// MARK: - Scroll View Delegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        let progressInPage = scrollView.contentOffset.x - (page * scrollView.bounds.width)
        let progress = CGFloat(page) + progressInPage
        
        snakePageControl.progress = progress
        filledPageControl.progress = progress
        pillPageControl.progress = progress
//        pageC.progress = progress
        scrollingPageControl.progress = progress
        if scrollView.isDragging || scrollView.isDecelerating {
            let page = scrollView.contentOffset.x / scrollView.bounds.width
            pageControl.setCurrentPage(page)
        }
    }
}
