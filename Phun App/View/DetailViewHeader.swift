//
//  DetailViewHeader.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/13/21.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewHeader: UICollectionReusableView{
    
    static let identifier = "detailHeader"
    var delegate: DetailCellDelegate?
    let buttonHeight = CGFloat(44)
    
    let backButton = UIButton()
    let shareButton = UIButton()
    
    let backImage = UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .medium))?.withTintColor(.white, renderingMode: .alwaysOriginal)
    
    let shareImage = UIImage(systemName: "square.and.arrow.up.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .medium))?.withTintColor(.white, renderingMode: .alwaysOriginal)
    
    let missionImageView: UIImageView = {
        let mi = UIImageView()
        mi.translatesAutoresizingMaskIntoConstraints = false
        mi.layer.masksToBounds = true
        mi.contentMode = .scaleAspectFill
        return mi
    }()
    
    public func configure(headerBounds: CGRect, item: Mission) {
        if let image = item.image {
            missionImageView.sd_setImage(
                with: URL(string: image),
                placeholderImage: UIImage(named: "placeholder"),
                options: SDWebImageOptions(rawValue: 0) 
            )
        } else {
            missionImageView.image = UIImage(named: "placeholder")
        }
        
        backButton.setupButton(image: backImage)
        shareButton.setupButton(image: shareImage)
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(backGesture)
        
        let shareGesture = UITapGestureRecognizer(target: self, action: #selector(goShare))
        shareButton.addGestureRecognizer(shareGesture)
        
        addSubview(backButton)
        addSubview(shareButton)
        addSubview(missionImageView)
        missionImageView.addBlackGradientLayerInBackground(frame: headerBounds, colors:[.clear, .black])

        setupLayout()
        
    }
    
    @objc private func goBack(sender: UITapGestureRecognizer) {
        delegate?.didPressBackButton()
    }
    
    @objc private func goShare(sender: UITapGestureRecognizer) {
        delegate?.didPressShareButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupLayout() {
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(14)
            make.width.height.equalTo(buttonHeight)
        }
        shareButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(14)
            make.width.height.equalTo(buttonHeight)
        }
        missionImageView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
}
