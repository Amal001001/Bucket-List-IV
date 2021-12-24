//  addItemTableViewController.swift
//  Bucket List

import UIKit

class addItemTableViewController: UITableViewController {

    @IBOutlet weak var itemTextView: UITextView!
    
    var item : String?
    var indexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTextView.text = item
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows
        return 1
    }
   
    var delegate: AddItemTableViewControllerDelegate?

    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelItemViewController(self, didPressCancelButton: sender)
    }

    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.addItemViewController(self, didFinishAddingItem: itemTextView.text!, at: indexPath)
    }
    
}
