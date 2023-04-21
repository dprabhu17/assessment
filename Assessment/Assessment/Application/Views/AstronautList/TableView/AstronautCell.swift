//
//  AstronautCell.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import UIKit

class AstronautCell: UITableViewCell {

    // MARK: Properties
    var model: Astronaut? {
        didSet {
            lblName.text = model?.name
            lblNationality.text = model?.nationality
            imgProfile.image = nil
        }
    }

    // To set image only for the visible cells
    var image: UIImage? {
        didSet {
            imgProfile.image = nil
            imgProfile.image = image
        }
    }

    // MARK: UIElements
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var vwCard: UIView!

    // MARK: Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        vwCard.setAsCardView()
        imgProfile.setAsCircle()
    }
}
