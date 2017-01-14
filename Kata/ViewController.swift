//
//  ViewController.swift
//  Kata
//
//  Created by Dharmesh Siddhpura on 1/11/17.
//  Copyright © 2017 Dharmesh Siddhpura. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var outputView: UITextView!
    @IBOutlet weak var txtField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        txtView.layer.borderWidth = 1.0
        txtView.layer.borderColor = UIColor.black.cgColor
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func viewTapped()
    {
        txtView.resignFirstResponder()
        txtField.resignFirstResponder()
    }
    
    @IBAction func calculate()
    {
        viewTapped()
        outputView.text = ""
        if(!txtView.text.isEmpty)
        {
            let data = txtView.text.data(using: String.Encoding.utf8)
            
            do
            {
                let array = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[Int]]
                
                if let xPosition = txtField.text, let row = Int(xPosition)
                {
                    let result = find(array: array, entryPoint: Point(x: row, y: 0))
                    outputView.text = "\(result.0)" + "\n\(result.1)" + "\n\(result.2)"
                }
                
                else
                {
                    outputView.text = "Please enter row#"
                }
            }
                
            catch
            {
                outputView.text = "Please check the input format as per the example on left."
            }
        }
    }
}

