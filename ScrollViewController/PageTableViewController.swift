//
//  TestTableViewController.swift
//  ScrollViewController
//
//  Created by jasnig on 16/4/20.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

// github: https://github.com/jasnig
// 简书: http://www.jianshu.com/p/b84f4dd96d0c

import UIKit
// MARK: PageTableViewDelegate
protocol PageTableViewDelegate: class {
    func scrollViewIsScrolling(scrollView: UIScrollView)
    func setupTableViewOffSetYWhenViewWillAppear(scrollView: UIScrollView)
}

class PageTableViewController: UIViewController {
    
    // 代理
    weak var delegate: PageTableViewDelegate?
    
    //
    var tableView: UITableView!
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        // 设置tableview的内容偏移量

        tableView.contentInset = UIEdgeInsets(top: defaultOffSetY, left: 0, bottom: 0, right: 0)
        
        self.view.addSubview(tableView)
    }
    
    
    /// !!! 不要在viewDidLoad()方法里面设置tableView或者collectionView的偏移量, 在初始化方法中设置偏移量,否则可能导致显示不正常
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        // 通知父控制器重新设置tableView的contentOffset.y
        delegate?.setupTableViewOffSetYWhenViewWillAppear(tableView)
//        print(tableView.contentOffset.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }




}

// MARK: UITableViewDelegate, UITableViewDataSource - 这里测试使用, 实际使用中可以重写这些方法
extension PageTableViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "未继承--------ceshishishihi"
        
        return cell
    }
}

// MARK: UIScrollViewDelegate - 监控tableview的滚动, 将改变通知给通知父控制器
extension PageTableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        delegate?.scrollViewIsScrolling(scrollView)
    }
}
