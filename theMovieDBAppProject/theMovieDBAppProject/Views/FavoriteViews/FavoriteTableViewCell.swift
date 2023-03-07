//
//  FavoriteTableViewCell.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/4/23.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var contentUIView: UIView!
    @IBOutlet weak var originalTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        titleImageView.image = nil
    }
}
