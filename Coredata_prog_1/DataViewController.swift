//
//  DataViewController.swift
//  Coredata_prog_1
//
//  Created by Navdeep on 01/08/2023.
//
import UIKit

protocol DataPass{
    func data(object:[String:String],index:Int,isEdit:Bool)
}

class DataViewController: UIViewController, UITableViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UISearchResultsUpdating,refresh {
    
    @IBOutlet var dataTable: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var contactsHeaderView: UIView!
    @IBAction func captureAndSave(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController,animated: true)
    }
    
    
    var image:UIImage!
    var indexButtonPressed = Int()
    var searchController:UISearchController!
    var student = [Students]()
    var filteredStudents = [Students]()
    var empty = [Students]()
    var favourite = [Students]()
    var delegate:DataPass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTable.dataSource = self
        dataTable.delegate = self
        self.title = "Records"
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Contacts"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.refreshData()
            favourite = student.filter{
                student in
                return student.noOfTimeClicked > 0
            }.sorted(by: { $0.noOfTimeClicked > $1.noOfTimeClicked })
                .prefix(3)
                .map{$0}
    }
    
    func refreshData() {
        student = DataBaseHelper.sharedIntance.get()
        updateSearchResults(for: searchController)
        favourite = student.filter{
            student in
            return student.noOfTimeClicked > 0
        }.sorted(by: { $0.noOfTimeClicked > $1.noOfTimeClicked })
            .prefix(3)
            .map{$0}
        dataTable.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let orientedImage = pickedImage.fixOrientation()
            if let data = orientedImage.pngData() {
                DataBaseHelper.sharedIntance.saveImage(imageData: data, at: indexButtonPressed )
            }
        }
        dismiss(animated: true)
        dataTable.reloadData()
    }
}

extension DataViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return searchController.isActive ? 0 : favourite.count
        }
        else {
            return searchController.isActive ? filteredStudents.count : student.count
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        indexButtonPressed = sender.tag
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0,favourite.count>0,!searchController.isActive{
            return headerView
        }
        else if section == 1,student.count>0{
            return contactsHeaderView
        }
        else{
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0, favourite.count > 0, !searchController.isActive {
            return 30
        } else if section == 1, student.count > 0{
            return 30
        } else {
            return 0
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dataTable.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath) as! TableViewCell
        cell.delegate = self
        cell.imageButton.tag = indexPath.row
        cell.imageButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        let studentToDisplay: Students
        if indexPath.section == 0{
            studentToDisplay = searchController.isActive ? empty[indexPath.row] : favourite[indexPath.row]
            cell.student = studentToDisplay
        }
        else{
            studentToDisplay = searchController.isActive ? filteredStudents[indexPath.row] : student[indexPath.row]
            cell.student = studentToDisplay
        }
        
        if let studentImage = studentToDisplay.profileImage {
                cell.imageProfile.image = UIImage(data: studentImage)
            } else {
                cell.imageProfile.image = UIImage(named: "user.png")
            }

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            student = DataBaseHelper.sharedIntance.delete(index: indexPath.row)
            refreshData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = ["name":student[indexPath.row].name ?? "N/A","address":student[indexPath.row].address ?? "N/A","city":student[indexPath.row].city ?? "N/A","mobile":student[indexPath.row].mobile ?? "N/A"]
        self.delegate.data(object: dict,index: indexPath.row,isEdit: true)
        let alert = UIAlertController(title: "Caution", message: "Do u want to edit your data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "yes", style: .default,handler: {
            _ in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default,handler: {_ in
            //do Nothing
        }))
        present(alert, animated: true)
    }
}

extension UIImage{
    func fixOrientation()->UIImage{
        if imageOrientation == .up{
            return self
        }
        else{
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return normalizedImage
        }
    }
}

extension DataViewController{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty{
            filteredStudents = student.filter {
                student in
                return student.name?.lowercased().contains(searchText.lowercased()) ?? false
            }.sorted(by: {$0.noOfTimeClicked > $1.noOfTimeClicked})
        }
        else{
            filteredStudents = student
        }
        dataTable.reloadData()
    }
}
