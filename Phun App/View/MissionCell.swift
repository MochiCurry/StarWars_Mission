//
//  MissionCell.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/12/21.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class MissionCell: UICollectionViewCell {
    
    private var missionDate = UILabel()
    private var missionTitle = UILabel()
    private var missionLocation = UILabel()
    private var missionDescription = UILabel()
    
    private var missionImageView: UIImageView = {
        let mi = UIImageView()
        mi.translatesAutoresizingMaskIntoConstraints = false
        mi.layer.masksToBounds = true
        mi.layer.cornerRadius = 12
        mi.contentMode = .scaleAspectFill
        return mi
    }()
    
    private var dynamicView: UIView = {
        let dv = UIView()
        dv.layer.masksToBounds = true
        dv.backgroundColor = .clear
        return dv
    }()
    
    private var transparentView: UIView = {
        let tv = UIView()
        tv.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        tv.layer.cornerRadius = 12
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        missionDate.setupLabel()
        missionTitle.setupLabel()
        missionLocation.setupLabel()
        missionDescription.setupLabel()
        
        missionDate.font = .boldSystemFont(ofSize: 18)
        missionTitle.font = .boldSystemFont(ofSize: 32)
        missionLocation.font = .boldSystemFont(ofSize: 18)
        
        contentView.addSubview(dynamicView)
        dynamicView.addSubview(missionImageView)
        dynamicView.addSubview(transparentView)
        dynamicView.addSubview(missionDate)
        dynamicView.addSubview(missionTitle)
        dynamicView.addSubview(missionLocation)
        dynamicView.addSubview(missionDescription)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(item: Mission) {
        missionTitle.text = item.title
        missionLocation.text = item.locationline1
        missionDescription.text = item.description
        
        if let image = item.image {
            missionImageView.sd_setImage(
                with: URL(string: image),
                placeholderImage: UIImage(named: "placeholder"),
                options: SDWebImageOptions(rawValue: 0) 
            )
        } else {
            missionImageView.image = UIImage(named: "placeholder")
        }
        
        if let dateString = item.date {
            if let dateInDate = DateFormatHelper.shared.stringToDate(date: dateString) {
                let dateFormatted = DateFormatHelper.shared.dateToString(date: dateInDate)
                missionDate.text = dateFormatted
            }
        }
    }
    
    private func setupLayout() {
        
        missionDate.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        missionTitle.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(missionDate.snp.bottom).offset(18)
        }
        missionLocation.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(missionTitle.snp.bottom).offset(24)
        }
        missionDescription.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(missionLocation.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(18)
        }
        dynamicView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(12)
        }
        missionImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        transparentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

    }
}
