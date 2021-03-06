 //
 //  MainView.swift
 //  Doenlijstje
 //
 //  Created by Pieter Kuijsten on 22/01/2017.
 //  Copyright © 2017 Pieter Kuijsten. All rights reserved.
 //
 
 import UIKit
 import CoreData
 
 class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate,  UITextFieldDelegate {
    
    @IBOutlet weak var inputVeld: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var controllerFetchRequest: NSFetchedResultsController<Todo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        fetchRequest()
    }
    
    
    @IBAction func submitBtn(_ sender: UIButton) {
        if inputVeld.text!.isEmpty {
            print("no text added")
        } else {
            let input = Todo(context: context)
            input.title = inputVeld.text
            input.created = NSDate()
            
            inputVeld.resignFirstResponder()
            
            ad.saveContext()
            
            inputVeld.text = ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controllerFetchRequest.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controllerFetchRequest.sections {
            return sections.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableContent", for: indexPath) as! TableContent
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: TableContent, indexPath: NSIndexPath) {
        let todo = controllerFetchRequest.object(at: indexPath as IndexPath)
        cell.configureCell(todo: todo)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoDel = controllerFetchRequest.object(at: indexPath as IndexPath)
            context.delete(todoDel)
            ad.saveContext()
        }
    }
    
    func fetchRequest() {
        let request = NSFetchRequest<Todo>(entityName: "Todo")
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        
        request.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controllerFetchRequest = controller
        
        do {
            try controllerFetchRequest.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputVeld.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputVeld.resignFirstResponder()
        return(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
 }
 
