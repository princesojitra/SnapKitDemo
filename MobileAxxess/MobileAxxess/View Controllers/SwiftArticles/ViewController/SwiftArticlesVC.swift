//
//  SwiftArticlesVC.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 01/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit
import CoreData
import SnapKit


class SwiftArticlesVC: UIViewController {
    
    //MARK: - Variables
    var contentView: SwiftArticleView {
        return view as! SwiftArticleView
    }
    
    var articleViewModels = [SwiftArticlesViewModel]()
    private let refreshControl = UIRefreshControl()
    
}


//MARK: - Lifecycle Methods
extension SwiftArticlesVC {
    
    //Load SwiftArticleView
    override func loadView() {
        self.view = SwiftArticleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setNeedsStatusBarAppearanceUpdate()
        self.setupNavigationBar()
        self.setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
}

//MARK: - Action Methods
extension SwiftArticlesVC {
    @objc func refreshData(_ refreshControl: UIRefreshControl) {
        self.fetchArticlesData(isShowLoader: false)
    }
    
    @objc func actionOnSortOption(_ sender: UIButton) {
        print("sort clicked")
        SwiftArticlesViewModel.showSortOption { (articletype) in
            self.loadSaveArticlesData(articleType: articletype)
        }
    }
}

//MARK: - Other Methods
extension SwiftArticlesVC {
    
    // Setup navigationbar
    func setupNavigationBar(){
        self.title = "Articles"
        self.navigationController?.navigationBar.barStyle = .black
        
        let btnSortOption = UIButton(type: .custom)
        btnSortOption.setImage(UIImage(named: "sort"), for: .normal)
        btnSortOption.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnSortOption.isUserInteractionEnabled = true
        btnSortOption.addTarget(self, action:#selector(actionOnSortOption(_:)), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: btnSortOption), animated: true)
    }
    
    
    // Setup tableview
    func setupTableView(){
        
        self.contentView.tblViewSwiftArticlesList.delegate = self
        self.contentView.tblViewSwiftArticlesList.dataSource = self
        
        if #available(iOS 10.0, *) {
            self.contentView.tblViewSwiftArticlesList.refreshControl = refreshControl
        } else {
            
            self.contentView.tblViewSwiftArticlesList.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        self.fetchArticlesData(isShowLoader: true)
    }
    
    // Fetch articles data from server
    func fetchArticlesData(isShowLoader:Bool){
        if  ConnectionCheck.isConnectedToInternet() {
            CoreDataContext.deleteAndRebuild()
            SwiftArticlesViewModel.fetchSwiftArticlsData(isShowLoader: true, articleType: ArticleType.All) { (articles) in
                self.articleViewModels =  articles.map({
                    return SwiftArticlesViewModel(article: $0)
                })
                self.stopLoaderWithEndRefreshing()
                self.contentView.tblViewSwiftArticlesList.reloadData()
            }
        }
        else{
            self.loadSaveArticlesData(articleType:ArticleType.All)
        }
    }
    
    func loadSaveArticlesData(articleType:ArticleType){
        var articles = [Articles]()
       
        switch articleType {
        case.All:
            articles = SwiftArticlesViewModel.loadSavedArticlesData(articleType: ArticleType.All)
            break
        case.Image:
            articles = SwiftArticlesViewModel.loadSavedArticlesData(articleType: ArticleType.Image)
            break
        case.Text:
            articles = SwiftArticlesViewModel.loadSavedArticlesData(articleType: ArticleType.Text)
            break
        }
        
        self.articleViewModels =  articles.map({
            return SwiftArticlesViewModel(article: $0)
        })
        self.stopLoaderWithEndRefreshing()
        self.contentView.tblViewSwiftArticlesList.reloadData()
    }
    
    // Stop Refresh control
    func stopLoaderWithEndRefreshing(){
        DispatchQueue.main.async {  [weak self] in
            CustomLoader.shared.hideLoader()
            guard let strongSelf = self else { return }
            if strongSelf.refreshControl.isRefreshing {
                strongSelf.refreshControl.endRefreshing()
            } else if !strongSelf.refreshControl.isHidden {
                strongSelf.refreshControl.beginRefreshing()
                strongSelf.refreshControl.endRefreshing()
            }
        }
    }
}

