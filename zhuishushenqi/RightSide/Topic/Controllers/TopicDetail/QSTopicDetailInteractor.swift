//
//  QSTopicDetailInteractor.swift
//  zhuishushenqi
//
//  Created caonongyun on 2017/4/20.
//  Copyright © 2017年 QS. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import QSNetwork
import ZSAPI

class QSTopicDetailInteractor: QSTopicDetailInteractorProtocol {

    var output: QSTopicDetailInteractorOutputProtocol?
    var id:String = ""
    var title:String = "主题书单"

    func requestDetail(){
        //        http://api.zhuishushenqi.com/book-list/58b782f5a7674a5f67618731
        let api = ZSAPI.themeDetail(key: id)
        //        QSNetwork.setDefaultURL(url: BASEURL)
        QSNetwork.request(api.path, method: HTTPMethodType.get, parameters: nil, headers: nil) { (response) in
            QSLog(response.json)
            if let bookList = response.json?.object(forKey: "bookList") as? [AnyHashable : Any], let books = (response.json?.object(forKey: "bookList") as AnyObject).object(forKey:"books"){
                if let headerModel = TopicDetailHeader.deserialize(from: bookList as? [String:Any]) ,let booksModel =  [TopicDetailModel].deserialize(from: books as? [Any]) as? [TopicDetailModel] {
                    self.output?.fetchListSuccess(list: booksModel, header: headerModel)

                } else {
                    self.output?.fetchListFailed()
                }
            }else{
                self.output?.fetchListFailed()
            }
        }
    }
    
    func showTitle(){
        self.output?.showTitle(title: title)
    }
}
