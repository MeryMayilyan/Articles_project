//

import UIKit

class ArticleCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleCategoryLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    func setUI() {
        articleImageView.layer.cornerRadius = articleImageView.frame.height / 2
    }

}
