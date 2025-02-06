//
//  CustomButton.swift
//  LoginUIKitMVVM
//
//  Created by aljon antiola on 2/6/25.
//

import UIKit

class CustomButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var spinner: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSpinner()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSpinner()
    }
    
    private func setupSpinner() {

        spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        
        // Center the spinner within the button
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Initially, the spinner is hidden
        spinner.isHidden = true
    }
    
    // Call this function to start the spinner
    func startSpinning() {
        isUserInteractionEnabled = false
        setTitle("", for: .normal)
        spinner.isHidden = false
        spinner.startAnimating()
    }

    func stopSpinning() {
        isUserInteractionEnabled = true
        setTitle("Sign in", for: .normal)
        spinner.stopAnimating()
        spinner.isHidden = true
    }

}


