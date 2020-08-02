//
//  SwiftArticleView.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 02/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import Foundation
import UIKit

class SwiftArticleView: UIView {
    
    private(set) var tblViewSwiftArticlesList = UITableView()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.frame = UIScreen.main.bounds
        self.initializeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //setup artlicle view
    private func initializeUI() {
        addSubview(tblViewSwiftArticlesList)
        tblViewSwiftArticlesList.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        
        tblViewSwiftArticlesList.register(SwiftArticleTblCell.self, forCellReuseIdentifier: Constants.TblCellIdentifier.ArticleList)
        tblViewSwiftArticlesList.estimatedRowHeight = 50
        tblViewSwiftArticlesList.tableFooterView = UIView()
        
    }
    
}
