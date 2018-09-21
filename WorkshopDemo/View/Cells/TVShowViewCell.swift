//
//  TVShowViewCell.swift
//  WorkshopDemo
//
//  Created by Hrvoje Stanisic on 20.09.18.
//  Copyright © 2018 WomenInTech. All rights reserved.
//

import Foundation
import UIKit

class TVShowViewCell: UITableViewCell {

    static let identifier = "TVShowViewCell"

    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    func configure(with tvShow: TvShow) {
        nameLabel.text = tvShow.name
        thumbnailView.loadImage(from: tvShow.thumbnail, placeHolder: nil)
    }

    override func prepareForReuse() {
        thumbnailView.image = nil
        nameLabel.text = ""
    }
}
