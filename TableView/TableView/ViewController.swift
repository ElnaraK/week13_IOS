//
//  ViewController.swift
//  TableView
//
//  Created by Elnara  on 4/5/20.
//  Copyright © 2020 Elnara . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(downloadModels), for: .valueChanged)
        
        return view
    }()
    
    var models: [Model] = []
    var info: Info?
    var fetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
        textField.addTarget(self, action: #selector(downloadSearch), for: UIControl.Event.editingChanged)
        textField.delegate = self
        downloadModels()
    }
    
    @objc func downloadModels() {
        Service.shared.downloadModels { response in
            self.models = response.models
            self.info = response.info
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    @objc func downloadSearch() {
        let search = self.textField.text
        self.models.removeAll()
        let url = "https://rickandmortyapi.com/api/character/?name=\(String(describing: search ?? ""))"
        Service.shared.downloadMore(url)
        {
            response in
            self.models += response.models
            self.info = response.info
            self.tableView.reloadData()
        }
    }
    
    @objc func downloadMore() {
        fetching = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute:{
            Service.shared.downloadMore(self.info!.next) { response in
                self.models += response.models
                self.info = response.info
                self.fetching = false
                self.tableView.reloadData()
            }
        })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "model", for: indexPath) as! TableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        cell.selectedBackgroundView = backgroundView
        
        cell.model = self.models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedModel = models[indexPath.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailViewController {
            viewController.model = selectedModel
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        let maximumOffset = height - scrollView.frame.size.height
        if (currentOffset > maximumOffset) {
            if !fetching{
                downloadMore()
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        self.models.removeAll()
        downloadModels()
        return true
    }
    
}
