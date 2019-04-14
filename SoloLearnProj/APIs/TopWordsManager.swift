
import Foundation

class TopWordsManager {
    
    static var shared = TopWordsManager()
    var topWordsDict = [String : Int]()
    var allWordsDict = [String : Int]()
    let topWordCount = 10
    var articleBody = ""
    
    private init() {}
    
    func getTopWords(text: String) -> [(String,Int)] {
       
        topWordsDict.removeAll()
        allWordsDict.removeAll()
        
        let words = text.components(separatedBy: .punctuationCharacters)
            .joined()
            .components(separatedBy: .whitespacesAndNewlines)
            .filter{!$0.isEmpty}
        
        for word in words {
            if allWordsDict[word] == nil {
                allWordsDict.updateValue(1, forKey: word)
            } else {
                let newValue = allWordsDict[word]! + 1
                allWordsDict.updateValue(newValue, forKey: word)
                if newValue >= topWordCount {
                    topWordsDict.updateValue(newValue, forKey: word)
                }
            }
        }
        
        let sortedDict = topWordsDict.sorted{$0.1 > $1.1}
        
        return sortedDict
    }
    
}
