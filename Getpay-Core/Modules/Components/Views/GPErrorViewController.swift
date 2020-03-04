//
//  GPErrorViewController.swift
//  Getpay-Core
//
//  Created by Leandro Lopes on 24/02/20.
//  Copyright © 2020 Getnet. All rights reserved.
//

import UIKit

public class GPErrorViewController: UIViewController, NibLoadable {
    // MARK: Properties
    public static var nibName: String {
        return String(describing: GPErrorViewController.self)
    }

    public static var bundle: Bundle {
        return Bundle(for: GPErrorViewController.self)
    }

    public var model: GPErrorMessage? {
        didSet {
            // self update
        }
    }
    
    // MARK: Life Cycke
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: IBActions
    
    @IBAction func confirmButton(sender: UIButton?) {
        self.dismiss(animated: true, completion: nil)
    }

}
