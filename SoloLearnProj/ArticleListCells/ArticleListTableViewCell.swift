
import UIKit

class ArticleListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleBackgroundView: UIView!
    
    var article: ArticleModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUITools()
    }

    func setUITools() {
        articleBackgroundView.layer.cornerRadius = 10.0
        articleBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        articleBackgroundView.layer.borderWidth = 0.5
    }
}


