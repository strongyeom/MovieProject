//
//  MovieTableViewCell.swift
//  MovieProject
//
//  Created by 염성필 on 2023/07/28.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var mainTitle: UILabel!
    
    @IBOutlet var releasedate: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(row: Movie) {
        
        self.mainImage.image = UIImage(named: row.title)
        self.mainImage.contentMode = .scaleToFill
        
        
        settingMainTitle(row: row)
        settingSubTitle(row: row)
        settingDescription(row: row)
        self.selectionStyle = .none
        
    }
    
    func settingMainTitle(row: Movie) {
        self.mainTitle.text = row.title
        self.mainTitle.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
    }
    
    func settingSubTitle(row: Movie) {
        let releaseDate = row.releaseDate
        let runtime = row.runtime
        let rate = row.rate
        
        self.releasedate.text = "\(releaseDate) | \(runtime)분 | \(rate)점"
        self.releasedate.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    func settingDescription(row: Movie) {
        self.descriptionLabel.text = row.overview
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
    }

}
