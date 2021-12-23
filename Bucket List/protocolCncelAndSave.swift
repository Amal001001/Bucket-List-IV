//  protocolCncelAndSave.swift
//  Bucket List

import UIKit

protocol AddItemTableViewControllerDelegate {
    func addItemViewController(_ controller: addItemTableViewController, didFinishAddingItem item: String, at atIndexPath: NSIndexPath?)
    func cancelItemViewController(_ controller: addItemTableViewController, didPressCancelButton button: UIBarButtonItem) 
}
