//
//  DetailCollectionView.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/12/21.
//

import Foundation
import UIKit
import SDWebImage

class DetailCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout, DetailCellDelegate {
    
    let cellId = "cellId"
    var popRecognizer: InteractivePopRecognizer?
    let headerHeight = CGFloat(300)
    var mission: Mission?
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
//    lazy var layout: CustomCollectionViewFlowLayout = {
//        let layout = CustomCollectionViewFlowLayout(display: .list, containerWidth: self.view.bounds.width)
//        return layout
//    }()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInteractiveRecognizer()
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        collectionView.contentInset.top = -height
        
        collectionView.backgroundColor = .black
        collectionView.register(DetailViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailViewHeader.identifier)
        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        self.reloadCollectionViewLayout(self.view.bounds.size.width)
//    }
//
//    private func reloadCollectionViewLayout(_ width: CGFloat) {
//        self.collectionViewFlowLayout.containerWidth = width
//        self.collectionViewFlowLayout.display = self.view.traitCollection.horizontalSizeClass == .compact && self.view.traitCollection.verticalSizeClass == .regular ? CollectionDisplay.list : CollectionDisplay.grid(columns: 2)
//
//    }
    
    
    
    
    
    
    private func setInteractiveRecognizer() {
        guard let controller = navigationController else {
            return
        }
        popRecognizer = InteractivePopRecognizer(controller: controller)
        controller.interactivePopGestureRecognizer?.delegate = popRecognizer
    }
}

extension DetailCollectionView {
    
    func didPressBackButton() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    func didPressShareButton() {
        let image = UIImage(named: "placeholder")
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension DetailCollectionView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailCell
        
        if let mission = mission {
            cell.configure(item: mission)
        }
        return cell
    }
}

extension DetailCollectionView {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.estimatedItemSize = CGSize(width: size.width, height: 10)
        layout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailViewHeader.identifier, for: indexPath) as! DetailViewHeader
        
        header.delegate = self
        let headerBounds = CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight)
        if let mission = mission {
            header.configure(headerBounds: headerBounds, item: mission)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: headerHeight)
    }
}
