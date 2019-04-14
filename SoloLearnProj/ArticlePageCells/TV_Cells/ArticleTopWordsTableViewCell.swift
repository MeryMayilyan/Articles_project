
import UIKit

protocol ArticleTopWordsTableViewCellDelegate: class {
    func didPressButton(tag: Int)
}

class ArticleTopWordsTableViewCell: UITableViewCell {

    weak var delegate : ArticleTopWordsTableViewCellDelegate?
    @IBOutlet weak var topWordButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func topWordButtonAction(_ sender: UIButton) {
        delegate?.didPressButton(tag: sender.tag)
    }
    
}
