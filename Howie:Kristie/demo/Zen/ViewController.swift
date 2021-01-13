//
//  ViewController.swift
//  Zen
//
//  Created by Haotian Ye on 1/10/21.
//

import UIKit

// Convert HEX value to UIColor
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

let textColor = hexStringToUIColor(hex: "083651")

// Progress Bar
@IBDesignable
class ProgressBar: UIView {
    @IBInspectable var color: UIColor? = .gray
    var progress: CGFloat = 0.5 {
        didSet { setNeedsDisplay() }
    }
    
    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.5).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        let progressLayer = CALayer()
        progressLayer.frame = progressRect
        
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = color?.cgColor
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var timeOfDay: UILabel!
    @IBOutlet weak var pun: UILabel!
    @IBOutlet weak var daily: UILabel!
    
    @IBAction func tips(_ sender: UIButton) {
        self.performSegue(withIdentifier: "tipsSegue", sender: self)
    }
    
    let timeList = ["Good Morning", "Good Afternoon", "Good Evening", "Good Night"]
    let punList = ["test1", "test2", "test3", "test4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        time()
    }
    
    func time() {
        let date = Date()
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date)
        
        timeOfDay.textColor = textColor
        pun.textColor = textColor
        
        if (hour >= 21) {
            timeOfDay.text = timeList[3]
            pun.text = punList[3]
        } else if (hour >= 17) {
            timeOfDay.text = timeList[2]
            pun.text = punList[2]
        } else if (hour >= 12) {
            timeOfDay.text = timeList[1]
            pun.text = punList[1]
        } else {
            timeOfDay.text = timeList[0]
            pun.text = punList[0]
        }
    }


}

