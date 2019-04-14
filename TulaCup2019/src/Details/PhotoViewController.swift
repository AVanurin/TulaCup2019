//
//  PhotoViewController.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 12/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import UIKit
import PureLayout


class PhotoViewController: UIViewController {
    
    var master: MasterViewController!
    var name: String!
    
    var photoView: UIImageView = UIImageView(image: nil)
    var photoImageimage: UIImage! {
        didSet {
            let ratio =  photoImageimage.size.width / photoImageimage.size.height
            print(ratio)
            print("====================================")
            
            let w = view.frame.width
            print(w)
            let h = w / ratio
            print(h)
            
            photoView.autoSetDimensions(to: CGSize(width: w, height: h))
            
            photoView.image = photoImageimage
            //photoView.image!.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: w, height: h)))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoView.backgroundColor = .gray
        view.addSubview(photoView)
        photoView.autoCenterInSuperview()
        //view = photoView
        
        let rightButton = UIBarButtonItem(title: "Действия", style: .done, target: self, action: #selector(action))
        navigationItem.rightBarButtonItem = rightButton

        // Do any additional setup after loading the view.
    }
    
    @objc func action() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
//        let addTag = UIAlertAction(title: "Добавить тег", style: .default) { _ in
//            print("Add tag")
//        }
//
//        let deleteTag = UIAlertAction(title: "Удалить тег", style: .default) { _ in
//            print("Delete tag")
//        }
        
        let setScore = UIAlertAction(title: "Поставить оценку", style: .default) { _ in
            self.showScorring()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
//        alert.addAction(addTag)
//        alert.addAction(deleteTag)
        alert.addAction(setScore)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    private func showScorring() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for ind in 0..<6 {
            let action = UIAlertAction(title: "\(ind)", style: .default) { _ in
                self.master.imagesScore[self.name] = ind
                self.master.collectionView.reloadData()
            }
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
