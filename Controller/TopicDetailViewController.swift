//
//  TopicDetailViewController.swift
//  V2ex-Swift
//
//  Created by huangfeng on 1/16/16.
//  Copyright © 2016 Fin. All rights reserved.
//

import UIKit

class TopicDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var topicId = "0"
    private var model:TopicDetailModel?
    
    private var _tableView :UITableView!
    private var tableView: UITableView {
        get{
            if(_tableView != nil){
                return _tableView!;
            }
            _tableView = UITableView();
            _tableView.estimatedRowHeight=100;
            _tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
            
            regClass(_tableView, cell: TopicDetailHeaderCell.self);
            
            _tableView.delegate = self;
            _tableView.dataSource = self;
            return _tableView!;
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "帖子详情"
        self.view.backgroundColor = V2EXColor.colors.v2_backgroundColor
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints{ (make) -> Void in
            make.top.right.bottom.left.right.equalTo(self.view);
        }
        
        TopicDetailModel.getTopicDetailById(self.topicId){
            (response:V2Response<TopicDetailModel?>) -> Void in
            if let aModel = response.value {
                self.model = aModel
                self.tableView.fin_reloadData()
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.model != nil{
            return 1
        }
        else {
            return 0;
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 1 {
            return tableView.fin_heightForCellWithIdentifier(TopicDetailHeaderCell.self, indexPath: indexPath) { (cell) -> Void in
                cell.bind(self.model!);
            }
        }
        return 0 ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: TopicDetailHeaderCell.self, indexPath: indexPath);
        cell.bind(self.model!);
        return cell;
    }
    
}