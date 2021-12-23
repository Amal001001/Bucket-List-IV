//  ViewController.swift
//  Bucket List

import UIKit

class ViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    var items = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskModel.getAllTasks() {
            data, response, error in
            // We get data, response, and error back. Data contains the JSON data,
            // Response contains the headers and other information about the response,
            // and Error contains an error if one occured
            
            // A "Do-Try-Catch" block involves a try statement with some catch block for catching any errors thrown by the try statement.
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let tasks = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray{
                   for task in tasks{
                       self.items.append(task)
                   }
                   DispatchQueue.main.async {
                       // Do something here to update the UI
                       self.tableView.reloadData()
                   }
                   print(tasks)
                }
             }catch{
                     print("Something went wrong")
             }
        }

    }

///////////////////////AddItemTableViewControllerDelegate .. protocol functions//////////////////////////////////////////
    func addItemViewController(_ controller: addItemTableViewController, didFinishAddingItem item: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            items[ip.row] = item
        }
        else{
            items.append(item)
        }
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
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
        cell.textLabel?.text = "\(items[indexPath.row])"
        // return cell so that Table View knows what to draw in each row
        return cell
    }
     
    //function for delete with a swipe
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            items.remove(at: indexPath.row)
            tableView.reloadData()
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
            let item = items[indexPath.row]
            addItemTableVC.item = "\(item)"
            addItemTableVC.indexPath = indexPath
        }
    }
    
}
