//
//  ViewController.swift
//  PulseAnimView
//
//  Created by nguyenkhiem7789@gmail.com on 04/18/2020.
//  Copyright (c) 2020 nguyenkhiem7789@gmail.com. All rights reserved.
//

import UIKit
import PulseAnimView

class ViewController: UIViewController {

    @IBOutlet weak var diecPhiImageView: PulseAnimView!

    override func viewDidLoad() {
        super.viewDidLoad()
        diecPhiImageView.about(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

