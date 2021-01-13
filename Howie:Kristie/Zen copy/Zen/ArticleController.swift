//
//  SelfCareController.swift
//  Zen
//
//  Created by Haotian Ye on 1/12/21.
//

import Foundation
import UIKit

struct Post: Decodable {
    let reference: String
    let title: String
    let author: String
    let content: String
}

class ArticleController: UIViewController {
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addBackground()
        text.setLineHeight(lineHeight: 1.1)
        scroll.contentLayoutGuide.bottomAnchor.constraint(equalTo: text.bottomAnchor).isActive = true
        setArticle()
    }
    
    func searchJSON() -> Post {
        if let path = Bundle.main.path(forResource: "articles", ofType: "json") {
            do {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path))
                let posts: [Post] = try! JSONDecoder().decode([Post].self, from: data)
                for post in posts {
                    if (post.reference == chosen) {
                        return post
                    }
                }
            }
        }
        return Post(reference: "", title: "", author: "", content: "")
    }
    
    func setArticle() {
        let article = searchJSON()
        print(article)
        name.text = article.title
        author.text = "Article by " + article.author
        text.text = article.content
    }
}


// Background
extension UIView {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "background")

        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill

        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
}

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font!, range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}
