//
//  SearchTableViewCell.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/2/23.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var contentUIView: UIView!
    @IBOutlet weak var originalTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
    }
    
    override func prepareForReuse() {
        titleImageView.image = nil
    }
    
    // MARK: - Configure cell in SearchResult media
    func configure(with SearchResultMediaMulti: SearchResultMedia) {
        loadingView.startAnimating()
        self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + (SearchResultMediaMulti.backdropPath ?? "https://picsum.photos/200"))),
                                        completed: { [weak self] _, _, _, _ in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            self.ratingLabel.text = String(format: "%.1f", SearchResultMediaMulti.voteAverage)
            self.originalTitle.text = SearchResultMediaMulti.originalTitle != nil && SearchResultMediaMulti.originalTitle != "" ? SearchResultMediaMulti.originalTitle : SearchResultMediaMulti.originalName
        })
    }
    
    // MARK: - Configure UI
    private func setupUI() {
        contentUIView.clipsToBounds = true
        titleImageView.layer.cornerRadius = 10
        ratingStackView.layer.cornerRadius = 5
    }
}
