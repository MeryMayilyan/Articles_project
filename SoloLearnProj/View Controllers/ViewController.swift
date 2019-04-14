
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let articleVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "article_page_vc") as! ArticlePageViewController
        navigationController?.pushViewController(articleVC, animated: true)
    }


}

