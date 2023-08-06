//
//  DataBaseHelper.swift
//  Coredata_prog_1
//
//  Created by Navdeep on 31/07/2023.
//

//In this file we will make all the func needed for database and only implmentation will be in ViewController file.
import Foundation
import CoreData
import UIKit

class DataBaseHelper{
    
    static var sharedIntance = DataBaseHelper() // we have made shared Instance
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(object:[String:String]){//we have made a dictionary here
        let student = NSEntityDescription.insertNewObject(forEntityName: "Students", into: context) as! Students
        student.name = object["name"]
        student.address = object["address"]
        student.city = object["city"]
        student.mobile = object["mobile"]
        do {
            try context.save()
        } catch  {
            print("data is not saved")
        }
    }
    
    func get() -> [Students]{
        var student = [Students]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Students")
        do{
            student =  try context.fetch(fetchRequest) as! [Students]
            
        }catch{
            print("cannot return data")
            
        }
        return student
    }
    
    func delete(index:Int) -> [Students]{
        var student = get()
        context.delete(student[index])
        student.remove(at:index)
        do{
            try context.save()
        }catch{
            print("Cannot delete data")
        }
        return student
    }
    
    func editData(object:[String:String],i:Int){
        let student = get()
        student[i].name = object["name"]
        student[i].address = object["address"]
        student[i].city = object["city"]
        student[i].mobile = object["mobile"]
        do{
            try context.save()
        }catch{
            print("data is not saved")
        }
        
    }
    
    func saveImage(imageData: Data,at index:Int){
        let students = get()
        students[index].profileImage = imageData
        do {
            try context.save()
        }
        catch{
            print("cannot save image")
        }
    }
}










