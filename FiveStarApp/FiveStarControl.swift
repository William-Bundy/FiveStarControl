//
//  FiveStarControl.swift
//  FiveStarApp
//
//  Created by William Bundy on 8/28/18.
//  Copyright © 2018 William Bundy. All rights reserved.
//

import Foundation
import UIKit

class FiveStarControl:UIControl
{
	let compDim:CGFloat = 40
	let maxStars = 5
	let starPadding:CGFloat = 8.0

	var rating:Int = 3

	var labels:[UILabel?] = []

	required init?(coder:NSCoder)
	{
		super.init(coder:coder)

		for i in 0..<maxStars {
			let ii = CGFloat(i)
			let l = UILabel(frame: CGRect(
				x: (compDim + starPadding) * ii,
				y: 0,
				width: compDim,
				height: compDim))

			l.font = UIFont.boldSystemFont(ofSize: 32)
			l.textAlignment = .center
			l.text = "."
			l.tag = i
			self.addSubview(l)
			self.labels.append(l)
		}
	}

	override var intrinsicContentSize: CGSize {
		let width = (compDim + starPadding) * CGFloat(maxStars)
		return CGSize(width: width, height: compDim)
	}

	func handleTouch(_ touch:UITouch)
	{
		var newRating = rating
		let point = touch.location(in: self)
		if point.x < 0 {
			newRating = 0
		} else if point.x > frame.width {
			newRating = maxStars
		} else {
			for i in 0..<maxStars {
				let left = CGFloat(i) * (compDim + starPadding)
				let right = left + compDim + starPadding
				if point.x > left && point.x < right {
					newRating = i + 1
				}

				labels[i]?.text = "."
			}
		}


		for i in 0..<newRating {
			labels[i]?.text = "#"
		}

		if newRating != rating {
			sendActions(for: [.valueChanged])
		}
	}

	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		if bounds.contains(touch.location(in: self)) {
			handleTouch(touch)
			sendActions(for: [.touchDown])
		}
		return true
	}

	override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		handleTouch(touch)
		if bounds.contains(touch.location(in: self)) {
			sendActions(for: [.touchDragInside])
		} else {
			sendActions(for: [.touchDragOutside])
		}
		return true
	}

	override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		defer { super.endTracking(touch, with: event) }
		guard let touch = touch else {return}

		if bounds.contains(touch.location(in: self)) {
			handleTouch(touch)
			sendActions(for: [.touchUpInside])
		} else {
			sendActions(for: [.touchUpOutside])
		}
	}

	override func cancelTracking(with event: UIEvent?) {
		sendActions(for: [.touchCancel])
	}

}
