//
//  SwiftArticlesViewModel.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 01/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit
import  CoreData

typealias ComplitionHandlerArticles = ([Articles]) -> Void
typealias CompletionHandlerSortOption = (ArticleType) -> Void

class SwiftArticlesViewModel {
    
    private let article :Articles
    
    var articleData :String {
        return self.article.data ?? ""
    }
    
    var articleDate :String {
        return (self.article.date ?? Date()).toString(withFormat: "dd MMMM, yyyy")
    }
    
    var articletype :String {
        return self.article.type ?? ""
    }
    
    var articleID :String {
        return self.article.id ?? ""
    }
    
    init(article:Articles) {
        self.article = article
    }
}

//Fetch articles data from server
extension SwiftArticlesViewModel  {
    class func fetchSwiftArticlsData(isShowLoader:Bool,articleType:ArticleType, complitionHandler: @escaping ComplitionHandlerArticles) {
        WebService.FetchSwiftArticles { (result) in
            switch result {
            case.failure(let error):
                print(error.localizedDescription)
                complitionHandler([Articles]())
                return
            case .success(let articles):
                guard let articlesFeedResult = articles as? [Articles] else {
                    print(ServiceError.invalidData.localizedDescription)
                    return }
                
                if articlesFeedResult.count > 0 {
                    for _ in articlesFeedResult {
                        CoreDataContext.saveContext()
                    }
                }
                let OfflineArticles = SwiftArticlesViewModel.loadSavedArticlesData(articleType: articleType)
                complitionHandler(OfflineArticles)
            }
        }
    }
    
    //Fetch articles data from offline database
    class func loadSavedArticlesData(articleType:ArticleType) -> [Articles] {
        
        let fetchRequest: NSFetchRequest<Articles> = Articles.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        switch articleType {
        case .Image:
            fetchRequest.predicate = NSPredicate(format: "type == %@","image")
            break
        case .Text:
            fetchRequest.predicate = NSPredicate(format: "type == %@","text")
            break
        case .All:
            break
        }
        do {
            let articlesData = try CoreDataContext.persistentContainer.viewContext.fetch(fetchRequest)
            print("Got \(articlesData.count) articles")
            return articlesData
        } catch {
            print("Fetch failed")
            return [Articles]()
        }
    }
}


extension SwiftArticlesViewModel {
    
    class func showSortOption(completionSortOption:@escaping CompletionHandlerSortOption){
        let alertController = UIAlertController.init(title: "Short Options" , message: ""  , preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction.init(title: "Image"  , style: .default , handler: { (alert) in
            completionSortOption(.Image)
        }))
        
        alertController.addAction(UIAlertAction.init(title: "Text"  , style: .default , handler: { (alert) in
            completionSortOption(.Text)
        }))
        
        alertController.addAction(UIAlertAction.init(title: "All"  , style: .default , handler: { (alert) in
            completionSortOption(.All)
        }))
        alertController.addAction(UIAlertAction.init(title:"Cancel"  , style: .cancel , handler: nil))
        Functions.topController().present(alertController, animated: true , completion: nil)
    }
}

