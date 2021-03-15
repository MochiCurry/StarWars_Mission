//
//  HomeCollectionView.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/12/21.
//

import Foundation
import UIKit

extension UIImageView {
    func addOverlay(on view: UIView) {
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        overlay.backgroundColor = UIColor.gray
        view.addSubview(overlay)
    }
}

class HomeCollectionView: BaseCollectionViewController {
    
    let cellId = "cellId"
    var missions: [Mission] = []
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        title = "Phun App"
        collectionView.backgroundColor = .white
        collectionView.register(MissionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        configureView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)

        configureView()
    }
    
    private func configureView() {

    }
    
    private func fetchData() {
        NetworkManager.shared.fetchMission { (result) in
            switch result {
            case .success(let missions):
                self.missions = missions
                for mission in missions {
                    print(mission)
                    print("/n")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
//                self.isDataFetched = true
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
        cell.item = mission
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mission = missions[indexPath.row]
        let vc = DetailCollectionView()
        vc.mission = mission
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width, height: 300)
        return .init(width: self.view.frame.width, height: 300)

    }
}
