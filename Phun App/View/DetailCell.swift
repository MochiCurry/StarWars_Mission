//
//  DetailCell.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/12/21.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

protocol DetailCellDelegate {
    func didPressBackButton()
    func didPressShareButton()
}

class DetailCell: UICollectionViewCell {
    
    
    var mission: Mission? {
        didSet {
            missionTitle.text = mission?.title
            missionLocation.text = mission?.locationline1
            missionDescription.text = mission?.description
            
            if let dateString = mission?.date {
                if let dateInDate = DateFormatHelper.shared.stringToDate(date: dateString) {
                    let dateFormatted = DateFormatHelper.shared.dateToString(date: dateInDate)
                    missionDate.text = dateFormatted
                }
            }
        }
    }
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    var buttonHeight = CGFloat(44)
    
    lazy var backButton: UIButton = {
        let bb = UIButton()
        let backImage = UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .medium))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        bb.setImage(backImage, for: .normal)
        bb.backgroundColor = .gray
        bb.layer.cornerRadius = buttonHeight / 2
        return bb
    }()
    
    lazy var shareButton: UIButton = {
        let sb = UIButton()
        let shareImage = UIImage(systemName: "square.and.arrow.up.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28, weight: .regular, scale: .medium))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        sb.setImage(shareImage, for: .normal)
        sb.backgroundColor = .gray
        sb.layer.cornerRadius = buttonHeight / 2
        return sb
    }()
    
//    let missionImageView: UIImageView = {
//        let mi = UIImageView()
//        mi.translatesAutoresizingMaskIntoConstraints = false
//        mi.layer.masksToBounds = true
//        mi.layer.cornerRadius = 12
//        mi.contentMode = .scaleAspectFill
//        return mi
//    }()
    
    var delegate: DetailCellDelegate?
    var missionDate = UILabel()
    var missionTitle = UILabel()
    var missionLocation = UILabel()
    var missionDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
               
        backgroundColor = .black
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let backGesture = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backButton.addGestureRecognizer(backGesture)
        
        let shareGesture = UITapGestureRecognizer(target: self, action: #selector(goShare))
        shareButton.addGestureRecognizer(shareGesture)
        
        setupView()
        setupLayout()
    }
    
    @objc private func goBack(sender: UITapGestureRecognizer) {
        delegate?.didPressBackButton()
    }
    
    @objc private func goShare(sender: UITapGestureRecognizer) {
        delegate?.didPressShareButton()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    private func setupView() {
        missionDate.setupLabel()
        missionTitle.setupLabel()
        missionLocation.setupLabel()
        missionDescription.setupLabel()
        
        missionDate.font = .boldSystemFont(ofSize: 18)
        missionTitle.font = .boldSystemFont(ofSize: 32)
        missionLocation.font = .boldSystemFont(ofSize: 18)
        
//        contentView.addSubview(backButton)
//        contentView.addSubview(shareButton)
//        contentView.addSubview(missionImageView)
        contentView.addSubview(missionDate)
        contentView.addSubview(missionTitle)
        contentView.addSubview(missionLocation)
        contentView.addSubview(missionDescription)
    }
    
    private func setupLayout() {
        
//        backButton.snp.makeConstraints { (make) in
//            make.top.leading.equalToSuperview().inset(14)
//            make.width.height.equalTo(buttonHeight)
//        }
//        shareButton.snp.makeConstraints { (make) in
//            make.top.trailing.equalToSuperview().inset(14)
//            make.width.height.equalTo(buttonHeight)
//        }
        missionDate.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().offset(24)
        }
        missionTitle.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(missionDate.snp.bottom).offset(24)
        }
        missionLocation.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(missionTitle.snp.bottom).offset(42)
        }
        missionDescription.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(missionLocation.snp.bottom).offset(12)
        }
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 24).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
