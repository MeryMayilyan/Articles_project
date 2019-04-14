
import UIKit

class TagsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var tagsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var articleTitleLabel: UILabel!
    var articleTitle: String? {
        didSet {
            self.articleTitleLabel.text = articleTitle
            makeTagsFromTitle()
        }
    }
    
    var tags = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setDelegates()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        tagsCollectionView.reloadData()
        
        self.frame = CGRect.init(origin: self.frame.origin, size: CGSize.init(width: self.superview?.frame.width ?? 0, height: self.frame.height))
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        tagsCollectionViewHeight.constant = tagsCollectionView.contentSize.height
    }

    func setDelegates() {
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
    }
    
    func makeTagsFromTitle() {
        tags = articleTitle!.components(separatedBy: " ")
    }
}

//MARK: UICollectionView delegate and datasource
extension TagsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tag_cv_Cell", for: indexPath) as! TagCollectionViewCell
        tagCell.tagLabel.text = tags[indexPath.row]
        
        return tagCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = tags[indexPath.row]
        let width = UILabel.textWidth(font: UIFont.systemFont(ofSize: 16), text: text)
        
        return CGSize(width: width + 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

