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
    
    private var delegate: DetailCellDelegate?
    private var buttonHeight = CGFloat(44)
    private var missionDate = UILabel()
    private var missionTitle = UILabel()
    private var missionLocation = UILabel()
    private var missionDescription = UILabel()
    
    private lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
               
        backgroundColor = .black
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(item: Mission) {
        missionTitle.text = item.title
        missionLocation.text = item.locationline1
        missionDescription.text = item.description
        
        if let dateString = item.date {
            if let dateInDate = DateFormatHelper.shared.stringToDate(date: dateString) {
                let dateFormatted = DateFormatHelper.shared.dateToString(date: dateInDate)
                missionDate.text = dateFormatted
            }
        }
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
        
        contentView.addSubview(missionDate)
        contentView.addSubview(missionTitle)
        contentView.addSubview(missionLocation)
        contentView.addSubview(missionDescription)
    }
    
    private func setupLayout() {
        missionDate.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalToSuperview().offset(24)
        }
        missionTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(missionDate.snp.bottom).offset(24)
        }
        missionLocation.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(missionTitle.snp.bottom).offset(42)
        }
        missionDescription.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(missionLocation.snp.bottom).offset(12)
        }
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 24).isActive = true
        }
    }
}
