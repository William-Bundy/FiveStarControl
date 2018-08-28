//
//  ViewController.swift
//  FiveStarApp
//
//  Created by William Bundy on 8/28/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	@IBAction func updateRating(_ sender: FiveStarControl) {
		self.title = sender.rating != 1 ?
			"Rating: \(sender.rating) stars" :
			"Rating: 1 star";
	}
}

