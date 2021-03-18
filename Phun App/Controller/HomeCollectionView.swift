//
//  HomeCollectionView.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/12/21.
//

import Foundation
import UIKit

class HomeCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var missions: [Mission] = []
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    lazy var layout: CustomCollectionViewFlowLayout = {
//        let layout = CustomCollectionViewFlowLayout(display: .list, containerWidth: self.view.bounds.width)
//        return layout
//    }()
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        self.reloadCollectionViewLayout(self.view.bounds.size.width)
//    }
//
//    private func reloadCollectionViewLayout(_ width: CGFloat) {
//        self.layout.containerWidth = width
//        self.layout.display = self.view.traitCollection.horizontalSizeClass == .compact && self.view.traitCollection.verticalSizeClass == .regular ? CollectionDisplay.list : CollectionDisplay.grid(columns: 4)
//    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        title = "Phun App"
        collectionView.backgroundColor = .white
        collectionView.register(MissionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.collectionViewLayout = layout
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    private func fetchData() {
        NetworkManager.shared.fetchMission { (result) in
            switch result {
            case .success(let missions):
                self.missions = missions
            case .failure(let err):
                print(err.localizedDescription)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension HomeCollectionView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return missions.count
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MissionCell
        
        let mission = missions[indexPath.row]
        cell.configure(item: mission)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mission = missions[indexPath.row]
        let vc = DetailCollectionView()
        vc.mission = mission
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width, height: 300)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height
//            {
//            case 480:
//                print("iPhone Classic")
//            case 960:
//                print("iPhone 4 or 4S")
//
//            case 1136:
//                print("iPhone 5 or 5S or 5C")
//
//            case 1334:
//                print("iPhone 6 or 6S")
//            case 2208:
//                print("iPhone 6+ or 6S+")
//            default:
//                print("unknown")
//            }
//        }
//
//        if UIDevice().userInterfaceIdiom == .pad {
//            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad &&
//                    (UIScreen.main.bounds.size.height == 1366 || UIScreen.main.bounds.size.width == 1366)) {
//                print("iPad Pro : 12.9 inch")
//            }
//            else if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad &&
//                        (UIScreen.main.bounds.size.height == 1024 || UIScreen.main.bounds.size.width == 1024)) {
//                print("iPad 2")
//                print("iPad Pro : 9.7 inch")
//                print("iPad Air/iPad Air 2")
//                print("iPad Retina")
//            } else {
//                print("iPad 3")
//            }
//        }
//        return CGSize(width: self.view.frame.width, height: 300)
//     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice().userInterfaceIdiom == .pad {
            let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout

            if UIDevice.current.orientation.isLandscape {
                let space: CGFloat = (10) + (10) + (10)
                let size: CGFloat = (view.frame.size.width - space) / 2.0
                return CGSize(width: size, height: size / 2)
                
            } else {
                let space: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0.0) + (flowLayout?.sectionInset.left ?? 0.0) + (flowLayout?.sectionInset.right ?? 0.0)
                let size: CGFloat = (view.frame.size.width - space) / 2.0
                return CGSize(width: size, height: size / 2)
            }
        }
        return CGSize(width: self.view.frame.width, height: 300)
    }
}
