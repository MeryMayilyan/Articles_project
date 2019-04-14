
import Foundation

protocol ArticleManagerDelegate: class {
    func didLoadArticles(fromIndex:Int, toIndex:Int)
}

class ArticleManager {
    
    static let shared = ArticleManager()
    private init() {}
    
    var isLoadingArticles = false
    let pageSize = 15
    var pageNumber = 0
    var articles = [ArticleModel]()
    
    weak var delegate : ArticleManagerDelegate?
    
    func getArticle(success:@escaping (_ response: ArticleResponseModel?)->Void, failer:@escaping (String)->Void ) {
        self.isLoadingArticles = true
        RequestManager.shared.getRequest("https://content.guardianapis.com/search?page=\(pageNumber)&page-size=\(pageSize)&api-key=bf44bdc6-be0f-4144-997e-17db5b638d09&show-fields=thumbnail,bodyText", success: { (response: ArticleResponseModel?) in
            self.isLoadingArticles = false
            if response != nil {
                success(response)
            }
        }) { (error: String) in
            self.isLoadingArticles = false
        }
    }
    
    func loadMoreData() {
        guard !isLoadingArticles else { return }
        pageNumber += 1
        getArticle(success: { (resp) in
            self.articles += (resp?.response.results)!
            self.delegate!.didLoadArticles(fromIndex: self.articles.count-resp!.response.results.count, toIndex: self.articles.count)
        }) { (err) in
            
        }
    }
}


