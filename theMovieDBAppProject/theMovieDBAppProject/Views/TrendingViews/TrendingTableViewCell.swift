//
//  TrendingTableViewCell.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 1/21/23.
//

import UIKit
import SDWebImage

class TrendingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var contentUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
    }
    
    override func prepareForReuse() {
        titleImageView.image = nil
    }
    
    // MARK: - Configure cell in movies
    func configure(with TrandingMovies: Movie) {
        loadingView.startAnimating()
        self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + (TrandingMovies.posterPath ?? "https://picsum.photos/200"))),
                                        completed: { [weak self] _, _, _, _ in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            self.ratingLabel.text = String(format: "%.1f", TrandingMovies.voteAverage)
        })
    }
    
    // MARK: - Configure cell in tvShows
    func configure(with TrandingTVShows: TVShows) {
        loadingView.startAnimating()
        self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + (TrandingTVShows.posterPath ?? "https://picsum.photos/200"))),
                                        completed: { [weak self] _, _, _, _ in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            self.ratingLabel.text = String(format: "%.1f", TrandingTVShows.voteAverage)
        })
    }
    
    // MARK: - Configure UI
    private func setupUI() {
        contentUIView.clipsToBounds = true
        titleImageView.layer.cornerRadius = 20
        ratingStackView.layer.cornerRadius = 5
    }
}



