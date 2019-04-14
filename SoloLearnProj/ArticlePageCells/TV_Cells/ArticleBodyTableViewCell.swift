
import UIKit

class ArticleBodyTableViewCell: UITableViewCell {

    @IBOutlet weak var articleBodyTextView: UITextView!
    
    var article : ArticleModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.articleBodyTextView.text = self.article.fields.bodyText
    }
    
    func highlightWords(searchWord: String){
        DispatchQueue.global().async {
            let articleBody = self.article.fields.bodyText
            
            let attributed = NSMutableAttributedString(string: articleBody)
            do
            {
                let regex = try! NSRegularExpression(pattern: "(?<=^|\\W)\(searchWord)[\\s,\\.,\\,,\\:]+", options: [.useUnicodeWordBoundaries])
                for match in regex.matches(in: articleBody, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: articleBody.count)) as [NSTextCheckingResult] {
                    attributed.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: match.range)
                }
                
                DispatchQueue.main.async {
                    attributed.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14.0), range: NSRange(location: 0,length: self.articleBodyTextView.text.count))
                    self.articleBodyTextView.attributedText = attributed
                }
        }
        }
    }
}


