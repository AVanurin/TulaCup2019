//
//  MasterViewController.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 04/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class MasterViewController: UIViewController, mainmodule {
    func didBecameActive() {
        initializeTask()
    }
    
    
    internal let cellId = "photoCellId"
    
    var imagesCount: Int = 0
    var imagesNames = [String]()
    var imagesUrls = [String: String]()
    var imagesScore = [String:Int]()
    var imagesImages = [String:UIImage]()
    
    var collectionView: UICollectionView!
    
//    var appDelegate: AppDelegate!
//    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = MasterFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(MasterCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .gray
        
        //test()
        
        initializeTask()
        initNaviUI()
        
//        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        context = appDelegate.persistentContainer.viewContext
        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Taged")
//        request.returnsObjectsAsFaults = false
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "name") as! String)
//            }
//        } catch {
//            print("Failed")
//        }
    }
    
    private func initNaviUI() {
        navigationItem.title = "TulaCup2019Data"
        
        let rightButton = UIBarButtonItem(title: "Фильтр", style: .done, target: self, action: #selector(filterTapped))
        //let leftButton = UIBarButtonItem(title: "Отображение", style: .done, target: self, action: #selector(pagingTapped))
        
        navigationItem.rightBarButtonItem = rightButton
        //navigationItem.leftBarButtonItem = leftButton
        
    }
    
    private func initializeTask() {
        if UserDefaults.standard.string(forKey: "token") == nil {
            handleAuth()
        } else {
            AppSettings.loadFromDevice()
            startLoading()
        }
    }
    
    private func startLoading() {
        getFilesList()
    }
    
    private func getFilesList() {
        ContentLoader.files() { images in
            self.imagesCount = images.count
            var imagesPrepared: Int = 0
            self.imagesNames = [String]()
            
            for image in images {
                self.imagesNames.append(image.name)
                self.imagesScore[image.name] = 0
            }
            
            
            for image in images {
                DispatchQueue.main.async() {
                    ContentLoader.file(path: image.path) { href in
                        self.imagesUrls[image.name] = href
                        let url = URL(string: href)!
                        
                        DispatchQueue.main.async() {
                            
                            self.getData(from: url) { data, response, error in
                                guard let data = data, error == nil else { return }
                                self.imagesImages[image.name] = UIImage(data: data)
                            }
                        }
                        
                        // WARNING THIS COULD CRASH!!!! NOT THREAD SAFE
                        imagesPrepared += 1
                        if imagesPrepared == self.imagesCount {
                            self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
        
    }
    
    private var onLoginClose: (()->(Void))?
    
    public func handleAuth() {
        let loginVC = LoginViewController()
        loginVC.manager = self
        
        onLoginClose = {
            AppSettings.saveToDevice()
            loginVC.dismiss(animated: true, completion: nil)
            ContentLoader.makeAppFolder()
        }
        present(loginVC, animated: true, completion: nil)
    }
    
    internal func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension MasterViewController: loginHandler {
    public func onSuccessAuth() {
        onLoginClose!()
    }
}

protocol loginHandler {
    func onSuccessAuth()
}

protocol mainmodule {
    func didBecameActive()
}
