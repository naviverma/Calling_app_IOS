//
//  TableViewCell.swift
//  Coredata_prog_1
//
//  Created by Navdeep on 01/08/2023.
//

import UIKit

protocol refresh{
    func refreshData()
}

class TableViewCell: UITableViewCell, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var imageButton: UIButton!
    @IBOutlet var number: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var callButton: UIImageView!
    @IBOutlet var name: UILabel!
    var delegate:refresh!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(didTapPhoneNumber))
        callButton.addGestureRecognizer(tapGesture1)
    }
    
    var student:Students!{
        didSet{
            name.text = student.name
            address.text = student.address
            city.text = student.city
            number.text = student.mobile
            if let photo = student.profileImage{
                imageProfile.image = UIImage(data: photo)
            }
        }
    }
    @objc func didTapPhoneNumber() {
        if let phoneNumber = number.text,
           let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            student.noOfTimeClicked = student.noOfTimeClicked + 1
            self.delegate.refreshData()
        }
        do {
            try student.managedObjectContext?.save()
            print(student.noOfTimeClicked)
        } catch {
            print("Could not save call count")
        }
    }

}
