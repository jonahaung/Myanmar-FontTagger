//
//  ViewController.swift
//  Myanmar FontTagger
//
//  Created by Aung Ko Min on 6/11/19.
//  Copyright © 2019 Aung Ko Min. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.layer.cornerRadius = 15
        textView.delegate = self
    }


}

extension ViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let subString = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if text == " " {
            let fontType = FontsTagger.shared.tagFont(for: subString)
            self.label.text = fontType.name
            textView.attributedText = NSAttributedString(string: subString, attributes: [.font: fontType.font])
            return false
        }
        
        return true
    }
}
