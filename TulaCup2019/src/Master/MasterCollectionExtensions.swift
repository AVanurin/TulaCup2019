//
//  MasterCollectionExtensions.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 04/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import Foundation
import UIKit

extension MasterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MasterCollectionViewCell
        cell.name = imagesNames[indexPath.row]

        let url = URL(string: imagesUrls[imagesNames[indexPath.row]]!)!

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                cell.imagePhotoView.image = UIImage(data: data)
            }
        }
        
        if let score = imagesScore[imagesNames[indexPath.row]] {
            cell.score = score
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //guard let cell = collectionView.cellForItem(at: indexPath) as? MasterCollectionViewCell else { return }
        
        guard let im = imagesImages[imagesNames[indexPath.row]] else {
            return
        }
        
        let vc = PhotoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
        vc.photoImageimage = im
        vc.name = imagesNames[indexPath.row]
        vc.master = self
        
    }
    
    @objc func filterTapped() {
        let vc = FilterViewController()
        vc.master = self
        
        print("Tapped!")
        
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc func pagingTapped() {
        print("paging tapped!")
    }
    
}
