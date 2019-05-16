//
//  FormPhotoCell.swift
//  FormLibrary
//
//  Created by Afees Lawal on 5/13/19.
//  Copyright © 2019 Afees Lawal. All rights reserved.
//

import UIKit
import Kingfisher

class FormPhotoCell: UICollectionViewCell, FormCell {
    
    public class Data: CellData {
        let imageUrl: String
        let imageHeight: CGFloat
        
        public init(imageUrl: String, imageHeight: CGFloat) {
            self.imageUrl = imageUrl
            self.imageHeight = imageHeight
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    /* The Image height */
    static var imageHeight: CGFloat = 60
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.backgroundColor = .red
    }
    
    func update(_ data: Data) {
        print(data.imageHeight)
        heightConstraint.constant = data.imageHeight
        widthConstraint.constant = data.imageHeight
        photoImageView.layer.cornerRadius = data.imageHeight / 2
        photoImageView.clipsToBounds = true
        
        if let url = URL(string: data.imageUrl) {
            
            photoImageView.kf.indicatorType = .activity
            photoImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    //.processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.errorCode)")
                }
            }
        }
    }

}
