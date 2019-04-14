
import UIKit
import Alamofire

class ArticlePageViewController: UIViewController {
   
    @IBOutlet weak var articleTableView: UITableView!
    var article : ArticleModel!
    var topWords : [(String,Int)]?
    var highlightButtonTag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleTableView.estimatedRowHeight = 100.0
        articleTableView.rowHeight = UITableView.automaticDimension
        topWords = TopWordsManager.shared.getTopWords(text: article.fields.bodyText)
        setDelegates()
    }
    
    func setDelegates() {
        articleTableView.delegate = self
        articleTableView.dataSource = self
    }
    
    func formattedDateFromString(dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy"
            return outputFormatter.string(from: date)
        }
        return nil
    }
}

//MARK: - UITableView delegate and DataSource

extension ArticlePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2 
        } else if section == 1 {
            return topWords!.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let articleCell = tableView.dequeueReusableCell(withIdentifier: "tag_tv_cell") as! TagsTableViewCell
                articleCell.articleTitle = article.webTitle
                return articleCell
            } else {
                let articleCell = tableView.dequeueReusableCell(withIdentifier: "article_body_tv_cell") as! ArticleBodyTableViewCell
                articleCell.article = article
                if let index = highlightButtonTag {
                    articleCell.highlightWords(searchWord: topWords![index].0)
                }
                
                return articleCell
            }
        } else if indexPath.section == 1 {
            let topWordsCell = tableView.dequeueReusableCell(withIdentifier: "article_top_words_tv_cell") as! ArticleTopWordsTableViewCell
            topWordsCell.topWordButton.setTitle(topWords![indexPath.row].0 + " (" + String(topWords![indexPath.row].1) + ")", for: .normal)
            topWordsCell.topWordButton.tag = indexPath.row
            topWordsCell.delegate = self
            return topWordsCell
        }
        else {
            let articleCell = tableView.dequeueReusableCell(withIdentifier: "article_category_tv_cell") as! ArticleCategoryTableViewCell
            articleCell.articleDateLabel.text = formattedDateFromString(dateString: article.webPublicationDate)
            articleCell.articleCategoryLabel.text = article.sectionName
            if let imageName = article.fields.thumbnail {
                articleCell.articleImageView.kf.setImage(with: URL(string: imageName))
            }
            
            return articleCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "top_words_header_cell")
        
        return cell?.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if topWords?.count != 0 && section == 1 {
            return 40
        }
        return 0
    }
}

extension ArticlePageViewController: ArticleTopWordsTableViewCellDelegate {
    func didPressButton(tag: Int) {
        highlightButtonTag = tag
        UIView.setAnimationsEnabled(false)
        self.articleTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: UITableView.RowAnimation.none)
        UIView.setAnimationsEnabled(true)
    
    }
}
