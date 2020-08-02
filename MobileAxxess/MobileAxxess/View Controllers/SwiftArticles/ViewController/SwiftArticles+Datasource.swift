//
//  SwiftArticles+UITableViewDatasource.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 01/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit

extension SwiftArticlesVC :UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let swiftArticleCell = tableView.dequeueReusableCell(withIdentifier: Constants.TblCellIdentifier.ArticleList) as! SwiftArticleTblCell
        let article = self.articleViewModels[indexPath.row]
        swiftArticleCell.articleViewModel = article
        return swiftArticleCell
    }
}
