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


extension UILabel {
    func setupLabel() {
//        let label = UILabel()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
//        self.font = .boldSystemFont(ofSize: 20)
        self.textColor = .white
//        return label
    }
}
class MissionCell: UICollectionViewCell {
    
    var item: Mission? {
        didSet {
//            missionDate.text = item?.date
            missionTitle.text = item?.title
            missionLocation.text = item?.locationline1
            missionDescription.text = item?.description
            
            if let image = item?.image {
//                missionImageView.sd_setImage(with: URL(string: image))
                missionImageView.sd_setImage(
                    with: URL(string: image),
                    placeholderImage: UIImage(named: "Empire"),
                    options: SDWebImageOptions(rawValue: 0) // YOU CAN ALSO DO TINT HERE
                )
            } else {
                missionImageView.image = UIImage(named: "Empire")
//                missionImageView.contentMode = .scaleAspectFit
            }
            
            if let dateString = item?.date {
                if let dateInDate = DateFormatHelper.shared.stringToDate(date: dateString) {
                    let dateFormatted = DateFormatHelper.shared.dateToString(date: dateInDate)
                    missionDate.text = dateFormatted
                }
            }
        }
    }
    
    var missionDate = UILabel()
    var missionTitle = UILabel()
    var missionLocation = UILabel()
    var missionDescription = UILabel()
    
    let missionImageView: UIImageView = {
        let mi = UIImageView()
        mi.translatesAutoresizingMaskIntoConstraints = false
        mi.layer.masksToBounds = true
        mi.layer.cornerRadius = 12
        mi.contentMode = .scaleAspectFill
        return mi
    }()
    
    let dynamicView: UIView = {
        let dv = UIView()
        dv.layer.masksToBounds = true
        dv.backgroundColor = .clear
        return dv
    }()
    
    let transparentView: UIView = {
        let tv = UIView()
        tv.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        tv.layer.cornerRadius = 12
        return tv
    }()
    
    
//    func setupLabel(label: UILabel) {
//        label.translatesAutoresizingMaskIntoConstraints = true
//        label.numberOfLines = 0
////        label.font = .boldSystemFont(ofSize: 20)
//        label.textColor = .white
////        return label
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
//        setupLabel(label: missionDate)
//        setupLabel(label: missionTitle)
//        setupLabel(label: missionLocation)
//        setupLabel(label: missionDescription)
//
        missionDate.setupLabel()
        missionTitle.setupLabel()
        missionLocation.setupLabel()
        missionDescription.setupLabel()
        
        missionDate.font = .boldSystemFont(ofSize: 18)
        missionTitle.font = .boldSystemFont(ofSize: 32)
        missionLocation.font = .boldSystemFont(ofSize: 18)
//        missionDescription.font = .boldSystemFont(ofSize: 24)
        
        contentView.addSubview(dynamicView)
        dynamicView.addSubview(missionImageView)
        dynamicView.addSubview(transparentView)
        dynamicView.addSubview(missionDate)
        dynamicView.addSubview(missionTitle)
        dynamicView.addSubview(missionLocation)
        dynamicView.addSubview(missionDescription)
        setupLayout()
    }
    
    func addOverlay(on view: UIView) {
        let overlay = UIView()
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        view.addSubview(overlay)
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

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
