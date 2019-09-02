//
//  ViewController.swift
//  TapeTextViewReadme
//
//  Created by Annino De Petra on 08/03/2020.
//  Copyright © 2020 Annino De Petra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var tapeTextViewContainerView: UIView!

	let font = UIFont.systemFont(ofSize: 36, weight: .bold)
	let tapeView = TapeTextView()

	override func viewDidLoad() {
		super.viewDidLoad()

		tapeView.translatesAutoresizingMaskIntoConstraints = false
		tapeTextViewContainerView.addSubview(tapeView)

		tapeView.leadingAnchor.constraint(equalTo: tapeTextViewContainerView.leadingAnchor).isActive = true
		tapeView.trailingAnchor.constraint(equalTo: tapeTextViewContainerView.trailingAnchor).isActive = true
		tapeView.topAnchor.constraint(equalTo: tapeTextViewContainerView.topAnchor).isActive = true
		tapeView.bottomAnchor.constraint(equalTo: tapeTextViewContainerView.bottomAnchor).isActive = true

		tapeView.attributedText = NSAttributedString(string: "Create a marker\npen effect using\nTapeTextView", attributes: [.font: font])
		tapeView.tapeColor = UIColor(red: 0.0, green: 0.667, blue: 0.357, alpha: 1.0)
	}

	@IBAction func degreesSliderChangedValue(_ sender: UISlider) {
		tapeView.degrees = CGFloat(sender.value)
	}

	@IBAction func heightSliderChangedValue(_ sender: UISlider) {
		tapeView.heightFactor = CGFloat(sender.value)

	}
}

