//
//  CharacterTableViewCell.swift
//  rick-and-morty
//
//  Created by Anna Gromova on 04.07.2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(_ data: CharacterResponseModel) {
        characterImageView.download(from: data.image)
        nameLabel.text = "Name: " + data.name
        idLabel.text = "ID: " + String(data.id)
        statusLabel.text = "Status: " + data.status
        speciesLabel.text = "Species: " + data.species
        genderLabel.text =  "Gender: " + data.gender
        locationLabel.text = "Location: " + data.location.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        idLabel.text = nil
        statusLabel.text = nil
        speciesLabel.text = nil
        genderLabel.text =  nil
        locationLabel.text = nil
    }
}
