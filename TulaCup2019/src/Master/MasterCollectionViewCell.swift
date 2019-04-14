//
//  MasterCollectionViewCell.swift
//  TulaCup2019
//
//  Created by Ванурин Алексей on 04/04/2019.
//  Copyright © 2019 Ванурин Алексей. All rights reserved.


import UIKit
import PureLayout


fileprivate let imageW: CGFloat = 100.0
fileprivate let imageH: CGFloat = 180.0
fileprivate let bottomH: CGFloat = 25.0


class MasterCollectionViewCell: UICollectionViewCell {
    var imagePhotoView: UIImageView!
    var likesLabel: UILabel!
    var sratsLabel: UILabel!
    var nameLabel: UILabel!
    
    var score: Int! {
        didSet {
            sratsLabel.text = "\(score!) звезд"
        }
    }
    
    var name: String! {
        didSet {
            nameLabel.text = name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUi()
        sratsLabel.text = "Нет оценки"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUi() {
        imagePhotoView = UIImageView()
        imagePhotoView.autoSetDimensions(to: CGSize(width: frame.width, height: UISettings.photoh-bottomH))
        imagePhotoView.backgroundColor = .gray
        
        addSubview(imagePhotoView)
        imagePhotoView.autoPinEdge(toSuperviewEdge: .top, withInset: 0.0)
        imagePhotoView.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
        imagePhotoView.autoPinEdge(toSuperviewEdge: .right, withInset: 0.0)
        
        let bottomView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.width, height: bottomH))
        bottomView.backgroundColor = .white
        
        addSubview(bottomView)
        bottomView.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
        bottomView.autoPinEdge(toSuperviewEdge: .right, withInset: 0.0)
        bottomView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0.0)
        bottomView.autoPinEdge(.top, to: .bottom, of: imagePhotoView, withOffset: 0.0)
        
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        
        bottomView.addSubview(nameLabel)
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 2.0)
        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 10.0)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 10.0)
        
        sratsLabel = UILabel()
        sratsLabel.textColor = .red
        sratsLabel.textAlignment = .left
        
        bottomView.addSubview(sratsLabel)
        sratsLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 5.0)
        sratsLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 2.0)
        
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        
    }
}
