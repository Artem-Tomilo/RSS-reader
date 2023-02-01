//
//  ActivityIndicator.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import UIKit

class ActivityIndicator {
    
    private let indicator = UIActivityIndicatorView(style: .large)
    
    func displayIndicator(view: UIView) {
        indicator.color = .black
        
        view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
}
