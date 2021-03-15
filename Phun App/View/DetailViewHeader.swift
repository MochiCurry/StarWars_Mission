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

    var item: Mission? {
        didSet {
            if let image = item?.image {
                missionImageView.sd_setImage(
                    with: URL(string: image),
                    placeholderImage: UIImage(named: "Empire"),
                    options: SDWebImageOptions(rawValue: 0) // YOU CAN ALSO DO TINT HERE
                )
            } else {
                missionImageView.image = UIImage(named: "Empire")
            }
        }
    }
    var buttonHeight = CGFloat(44)
    
    lazy var backButton: UIButton = {
        let bb = UIButton()
        let backImage = UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .medium))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        bb.setImage(backImage, for: .normal)
        bb.backgroundColor = .gray
        bb.layer.cornerRadius = buttonHeight / 2
        bb.layer.zPosition = 10
        return bb
    }()
    
    lazy var shareButton: UIButton = {
        let sb = UIButton()
        let shareImage = UIImage(systemName: "square.and.arrow.up.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .medium))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        sb.setImage(shareImage, for: .normal)
        sb.backgroundColor = .gray
        sb.layer.cornerRadius = buttonHeight / 2
        sb.layer.zPosition = 10
        return sb
    }()
    
    let missionImageView: UIImageView = {
        let mi = UIImageView()
        mi.translatesAutoresizingMaskIntoConstraints = false
        mi.layer.masksToBounds = true
        mi.contentMode = .scaleAspectFill
        return mi
    }()
    
    public func configure() {        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(backGesture)
        
        let shareGesture = UITapGestureRecognizer(target: self, action: #selector(goShare))
        shareButton.addGestureRecognizer(shareGesture)
        
        addSubview(backButton)
        addSubview(shareButton)
        addSubview(missionImageView)
        missionImageView.addBlackGradientLayerInBackground(frame: missionImageView.bounds, colors:[.clear, .black])
//        missionImageView.addBlackGradientLayerInForeground(frame: missionImageView.bounds, colors:[.clear, .black])

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
