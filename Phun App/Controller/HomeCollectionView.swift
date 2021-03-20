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
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        title = "Phun App"
        collectionView.backgroundColor = .white
        collectionView.register(MissionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
}

extension HomeCollectionView {

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice().userInterfaceIdiom == .pad {
            let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
            
            if UIDevice.current.orientation.isLandscape {
                let space: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0.0) + (flowLayout?.sectionInset.left ?? 0.0) + (flowLayout?.sectionInset.right ?? 0.0)
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
