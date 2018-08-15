//
//  ViewController.swift
//  CoinSaver
//
//  Created by Ryan Morrison on 05/08/2018.
//  Copyright © 2018 Ryan Morrison. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    var bannerView: GADBannerView!
    
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var onePenceText: UITextField!
    @IBOutlet weak var twoPenceText: UITextField!
    @IBOutlet weak var fivePenceText: UITextField!
    @IBOutlet weak var tenPenceText: UITextField!
    @IBOutlet weak var twentyPenceText: UITextField!
    @IBOutlet weak var fiftyPenceText: UITextField!
    @IBOutlet weak var onePoundText: UITextField!
    @IBOutlet weak var twoPoundText: UITextField!
    @IBOutlet weak var fivePoundNoteText: UITextField!
    @IBOutlet weak var tenPoundNoteText: UITextField!
    @IBOutlet weak var twentyPoundNoteText: UITextField!
    @IBOutlet weak var fiftyPoundNote: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Calculate", style: .plain, target: self, action: #selector(calculate))
    }
    
    func returnTotal() -> String {
        let one:Double = Double(onePenceText.text ?? "0") ?? 0
        let two:Double = Double(twoPenceText.text ?? "0") ?? 0
        let five:Double = Double(fivePenceText.text ?? "0") ?? 0
        let ten:Double = Double(tenPenceText.text ?? "0") ?? 0
        let twenty:Double = Double(twentyPenceText.text ?? "0") ?? 0
        let fifty:Double = Double(fiftyPenceText.text ?? "0") ?? 0
        let onePound:Double = Double(onePoundText.text ?? "0") ?? 0
        let twoPound:Double = Double(twoPoundText.text ?? "0") ?? 0
        let fiveNote:Double = Double(fivePoundNoteText.text ?? "0") ?? 0
        let tenNote:Double = Double(tenPoundNoteText.text ?? "0") ?? 0
        let twentyNote:Double = Double(twentyPoundNoteText.text ?? "0") ?? 0
        let fiftyNote:Double = Double(fiftyPoundNote.text ?? "0") ?? 0
        
        let result = (one / 100) + (two / 50) + (five / 25) + (ten / 10) + (twenty / 5) + (fifty / 2) + onePound + (twoPound * 2) + (fiveNote * 5) + (tenNote * 10) + (twentyNote * 20) + (fiftyNote * 50)
        
        let formatter = NumberFormatter();
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_UK")
        let priceString = formatter.string(from: result as NSNumber)!
        
        return priceString
    }

    @IBAction func calculate(_ sender: UIBarButtonItem){
        resultLabel.text = returnTotal()
         self.hideKeyboardWhenTappedAround()
        dismissKeyboard()
    }
    
    @IBAction func refresh(_ sender: Any) {
        resultLabel.text = ""
        onePenceText.text = ""
        twoPenceText.text = ""
        fivePenceText.text = ""
        tenPenceText.text = ""
        twentyPenceText.text = ""
        fiftyPenceText.text = ""
        onePoundText.text = ""
        twoPoundText.text = ""
        fivePoundNoteText.text = ""
        tenPoundNoteText.text = ""
        twentyPoundNoteText.text = ""
        fiftyPoundNote.text = ""
    }
    
  
    
    @objc func reportTapped(_ sender: UIBarButtonItem) {
        let formatter = UIMarkupTextPrintFormatter(markupText: html())
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(formatter, startingAtPageAt: 0)
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage()
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }
        UIGraphicsEndPDFContext()
        let shareVC = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        present(shareVC, animated: true, completion: nil)
    }

}

extension ViewController {
    func html() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let stringOutput = dateFormatter.string(from: date)
        
        var html = "<html><head><title>CoinSaver UK 💰 Report</title></head><body><br /><br />"
        html += "<h1 style=\"color:#F5A525\">CoinSaver UK 💰 Report</h1>"
        html += "<h3>On \(stringOutput)</h3>"
        html += "<h2>Total saved: \(returnTotal())</h2>"
        html += "<ul>"
        
        if onePenceText.text != "" {
            html += "<li><b>1p:</b> \(String(describing: onePenceText.text!))</li>"
        } else {
            html += "<li><b>1p:</b> 0p</li>"
        }
        
        if twoPenceText.text != "" {
            html += "<li><b>2p:</b> \(String(describing: twoPenceText.text!))</li>"
        } else {
            html += "<li><b>2p:</b> 0p</li>"
        }
        
        if fivePenceText.text != "" {
            html += "<li><b>5p:</b> \(String(describing: fivePenceText.text!))</li>"
        } else {
            html += "<li><b>5p:</b> 0p</li>"
        }
        
        if tenPenceText.text != "" {
             html += "<li><b>10p:</b> \(String(describing: tenPenceText.text!))</li>"
        } else {
            html += "<li><b>10p:</b> 0p</li>"
        }
        
        if twentyPenceText.text != "" {
            html += "<li><b>20p:</b> \(String(describing: twentyPenceText.text!))</li>"
        } else {
            html += "<li><b>20p:</b> 0p</li>"
        }
        
        if fiftyPenceText.text != "" {
            html += "<li><b>50p:</b> \(String(describing: fiftyPenceText.text!))</li>"
        } else {
            html += "<li><b>50p:</b> 0p</li>"
        }
        
        if onePoundText.text != "" {
            html += "<li><b>£1:</b> \(String(describing: onePoundText.text!))</li>"
        } else {
            html += "<li><b>£1:</b> 0p</li>"
        }
        
        if twoPoundText.text != "" {
            html += "<li><b>£2:</b> \(String(describing: twoPoundText.text!))</li>"
        } else {
            html += "<li><b>£2:</b> 0p</li>"
        }
        
        if fivePoundNoteText.text != "" {
            html += "<li><b>£5:</b> \(String(describing: fivePoundNoteText.text!))</li>"
        } else {
            html += "<li><b>£5:</b> 0p</li>"
        }
        
        if tenPoundNoteText.text != "" {
            html += "<li><b>£10:</b> \(String(describing: tenPoundNoteText.text!))</li>"
        } else {
            html += "<li><b>£10:</b> 0p</li>"
        }
        
        if twentyPoundNoteText.text != "" {
            html += "<li><b>£20:</b> \(String(describing: twentyPoundNoteText.text!))</li>"
        } else {
            html += "<li><b>£20:</b> 0p</li>"
        }
        
        if fiftyPoundNote.text != "" {
            html += "<li><b>£50:</b> \(String(describing: fiftyPoundNote.text!))</li>"
        } else {
            html += "<li><b>£50:</b> 0p</li>"
        }
        
        html += "</ul></body></html>"
        return html
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
