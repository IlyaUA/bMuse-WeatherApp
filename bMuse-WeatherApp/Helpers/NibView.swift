//
//  NibView.swift
//  bMuse-WeatherApp
//
//  Created by Ilya Kharebashvili on 23.08.2021.
//

import UIKit

// NibView Configurator
class NibView: UIView, Nibable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupNib()
    }
    
    private func setupNib() {
        guard let view = loadNib() else { return }
        addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupUI()
    }
    
    private func loadNib() -> UIView? {
        guard let nib = Self.nib else { return nil }
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setupUI() {}
}
