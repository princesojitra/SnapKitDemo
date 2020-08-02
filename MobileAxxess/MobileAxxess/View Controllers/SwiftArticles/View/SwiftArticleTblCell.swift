//
//  SwiftArticleTblCell.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 01/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit

//Article Types
enum ArticleType:String {
    case Image = "image"
    case Text = "text"
    case All
}

class SwiftArticleTblCell: UITableViewCell {
    
    lazy var lblArticleDate :UILabel = UILabel()
    lazy var lblArticleData :UILabel = UILabel()
    lazy var imgArticle :UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //setup customcell UI
    func configureCellUI() {
        //Setup date label
        self.selectionStyle = .none
        self.addSubview(self.lblArticleDate)
        self.addSubview(self.imgArticle)
        self.addSubview(self.lblArticleData)
        
        self.lblArticleDate.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(15)
        }
        
        self.imgArticle.snp.makeConstraints({ (make) in
            make.top.equalTo(self.lblArticleDate.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(200)
        })
        
        self.lblArticleData.snp.makeConstraints({ (make) in
            make.top.equalTo(self.imgArticle.snp.bottom).offset(15)
            make.left.right.bottom.equalToSuperview().inset(15)
        })
        self.lblArticleData.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    //set articlesdata
    var articleViewModel : SwiftArticlesViewModel! {
        didSet{
            
            self.lblArticleDate.numberOfLines = 1
            self.lblArticleData.numberOfLines = 0
            self.imgArticle.contentMode = .redraw
            self.imgArticle.layer.cornerRadius = 15
            self.imgArticle.layer.borderWidth = 1.5
            self.imgArticle.layer.borderColor = AppColor.Color_NavyBlue.cgColor
            self.imgArticle.clipsToBounds = true
            
            self.lblArticleDate.text =  articleViewModel.articleDate
            
            //check if article image is present then show image otherwise text
            if  articleViewModel.articletype == ArticleType.Image.rawValue {
                self.imgArticle.setImageWith(urlString: articleViewModel.articleData, placeholder: nil, imageIndicator: .gray, completion: nil)
                //update constarint to show image
                self.imgArticle.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.lblArticleDate.snp.bottom).offset(15)
                    make.height.equalTo(200)
                })
                self.layoutIfNeeded()
                
            }
            else{
                //update constarint to hide image
                self.imgArticle.snp.updateConstraints({ (make) in
                    make.height.equalTo(0)
                    make.top.equalTo(self.lblArticleDate.snp.bottom).offset(0)
                })
                self.layoutIfNeeded()
                
                self.lblArticleData.text = ""
                self.lblArticleData.text = articleViewModel.articleData
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
