
import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        setUITools()
    }
    
    func setUITools() {
        tagView.layer.cornerRadius = tagView.frame.size.height / 2
        tagView.backgroundColor = UIColor.newLightGray
        tagLabel.textColor = UIColor.gray
    }
    
    func selectItem(selected: Bool) {
        if selected {
            tagView.backgroundColor = UIColor.black
            tagLabel.textColor = .white
        } else {
            tagView.backgroundColor = UIColor.newLightGray
            tagLabel.textColor = UIColor.lightGray
        }
    }
}

