
import UIKit
import Kingfisher

class ArticleListPageViewController: UIViewController {

    var scrollVelocity: CGPoint = CGPoint.zero
    var scrollTargetContentOffset:CGPoint = CGPoint.zero
    @IBOutlet weak var articleListTableViewFooterView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var articleListTableView: UITableView!
    var articleTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ArticleManager.shared.loadMoreData()
        setDelegates()
        articleListTableView.estimatedRowHeight = 288.0
    }
    
    func setDelegates() {
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        articleListTableView.prefetchDataSource = self
        ArticleManager.shared.delegate = self
    }
}

//MARK: - UITableView delegate and datasource
extension ArticleListPageViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleManager.shared.articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 288.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleListCell = tableView.dequeueReusableCell(withIdentifier: "article_list_tv_cell") as! ArticleListTableViewCell
        articleListCell.articleTitleLabel.text! = ArticleManager.shared.articles[indexPath.row].webTitle
        let article = ArticleManager.shared.articles[indexPath.row]
        articleListCell.article = article
        articleListCell.imageView?.image = nil
        
        if let imageName = article.fields.thumbnail {
            if articleListCell.article?.webTitle == article.webTitle {
                articleListCell.articleImageView.kf.setImage(with: URL(string: imageName))
            }
        }
        
        return articleListCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == ArticleManager.shared.articles.count - 5 {
            ArticleManager.shared.loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "article_page_vc") as! ArticlePageViewController
        articleVC.article = ArticleManager.shared.articles[indexPath.row]
        
        navigationController?.pushViewController(articleVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
       
    }
    
}

extension ArticleListPageViewController: ArticleManagerDelegate {
    
    func didLoadArticles(fromIndex: Int, toIndex: Int) {
        DispatchQueue.main.async {
            self.articleListTableView.reloadData()
        }
    }
}
