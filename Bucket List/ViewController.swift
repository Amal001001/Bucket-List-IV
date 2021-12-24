//  ViewController.swift
//  Bucket List

import UIKit

class ViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = [Tasks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromApi()
    }

    //////////////////// func to get data from the api ////////////////////////////////////
    func getDataFromApi(){
        TaskModel.getAllTasks(completionHandler:{
        data, response, error in
        // We get data, response, and error back. Data contains the JSON data,
        // Response contains the headers and other information about the response,
        // and Error contains an error if one occured
        
        // A "Do-Try-Catch" block involves a try statement with some catch block for catching any errors thrown by the try statement.
        do {
            self.items = try JSONDecoder().decode([Tasks].self, from: data!)
               DispatchQueue.main.async {
                   // Do something here to update the UI
                   self.tableView.reloadData()
               }
            print(self.items)
         }catch{
                print("Something went wrong")
         }
      })
    }
    
///////////////////////AddItemTableViewControllerDelegate .. protocol functions//////////////////////////////////////////
    func addItemViewController(_ controller: addItemTableViewController, didFinishAddingItem item: String, at indexPath: NSIndexPath?) {
        
        if let ip = indexPath {
            //////////////////// update a task in the api ////////////////////////////////////
            TaskModel.updateTask(id: items[ip.row].id, objective: item, completionHandler:{
                data, response, error in
                DispatchQueue.main.async {
                   self.getDataFromApi()
                }
            })
       }else{
            //////////////////// post in the api ////////////////////////////////////
            TaskModel.addTaskWithObjective(objective: item , completionHandler:{
                data, response, error in
                DispatchQueue.main.async{
                   self.getDataFromApi()
                }
            })
        }
        dismiss(animated: true, completion: nil)
    }
    
    func cancelItemViewController(_ controller: addItemTableViewController, didPressCancelButton button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
///////////////////////////////tableView functions/////////////////////////////////////////////
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(items[indexPath.row].objective)"
        // return cell so that Table View knows what to draw in each row
        return cell
    }
     
    //function for delete with a swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
        //////////////////// delete item in  the api ////////////////////////////////////
        TaskModel.deleteTask(id: items[indexPath.row].id){
            data, response, error in
                DispatchQueue.main.async{
                  self.getDataFromApi()
                }
        }
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "ItemSegue", sender: indexPath)
    }
 
    //function perform something to a clicked row
//        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
///////////////////////////////segue function to addItemTableViewController/////////////////////////////////////////////
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
           let navigationController = segue.destination as! UINavigationController
           let addItemTableVC = navigationController.topViewController as! addItemTableViewController
           addItemTableVC.delegate = self
        
        if sender is NSIndexPath {
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row].objective
            addItemTableVC.item = "\(item)"
            addItemTableVC.indexPath = indexPath
        }
    }
    
}
