//
//  TvShowDetailsViewController.swift
//  WorkshopDemo
//
//  Created by Hrvoje Stanisic on 21.09.18.
//  Copyright © 2018 WomenInTech. All rights reserved.
//

import Foundation
import UIKit

final class TVShowDetialsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    var tvShow: TvShow?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: tvShow)
    }

    func configure(with viewModel: TvShow?) {
        guard let tvShow = tvShow else { return }
        nameLabel.text = tvShow.name
        infoLabel.text = tvShow.overview
        imageView.loadImage(from: tvShow.poster, placeHolder: nil)
    }
}
