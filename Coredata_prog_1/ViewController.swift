//
//  ViewController.swift
//  Coredata_prog_1
//
//  Created by Navdeep on 31/07/2023.
//

//In DataBaseHelper file we will make all the func needed for database and only implmentation will be in ViewController file.
import UIKit

class ViewController: UIViewController,DataPass{
    func data(object: [String : String], index: Int, isEdit: Bool) {
        name.text = object["name"]
        address.text = object["address"]
        city.text = object["city"]
        mobile.text = object["mobile"]
        i = index
        isUpdate = isEdit
    }
    
    @IBOutlet var mobile: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var entryTableView: UITableView!
    
    var i = Int ()
    var isUpdate:Bool = false
    
    @IBAction func listshow(_ sender: Any) {
        performSegue(withIdentifier: "savetoprofile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savetoprofile",
           let dataViewController = segue.destination as? DataViewController {
            dataViewController.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Entry"
        let tableheaderView = headerView
        entryTableView.tableHeaderView = tableheaderView
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }

    @IBOutlet var headerView: UIView!
    @IBAction func save(_ sender: Any) {
        let dict = ["name":name.text ?? "N/A","address":address.text ?? "N/A","city":city.text ?? "N/A","mobile":mobile.text ?? "N/A"]
        let alert = UIAlertController(title: "Caution", message: "Your data is saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        present(alert, animated: true)
        if isUpdate{
            DataBaseHelper.sharedIntance.editData(object: dict, i: self.i)
            isUpdate = false
        }else{
            DataBaseHelper.sharedIntance.save(object: dict)
        }
    }
}

