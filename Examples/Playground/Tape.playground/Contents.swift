//: Playground - noun: a place where people can play
extension CGFloat {
	var toRadiants: CGFloat {
		self * .pi / 180
	}
}
import UIKit
import PlaygroundSupport

final class TapeTextView: UITextView, NSLayoutManagerDelegate {

	private var _degrees: CGFloat = 0 {
		didSet {
			setNeedsDisplay()
		}
	}

	var degrees: CGFloat {
		get {
			return _degrees
		}

		set {
			_degrees = max(0, min(90, newValue))
		}
	}

	private var _heightFactor: CGFloat = 1 {
		   didSet {
			   setNeedsDisplay()
		   }
	   }

	var heightFactor: CGFloat {
		get {
			return _heightFactor
		}

		set {
			_heightFactor = max(0, min(1, newValue))
		}
	}

	var lineSpacing: CGFloat = 15 {
		didSet {
			setNeedsDisplay()
		}
	}

	var tapeColor: UIColor? {
		didSet {
			setNeedsDisplay()
		}
	}

	var autoresizeBasedOnTextLength: Bool = false {
		didSet {
			if autoresizeBasedOnTextLength {
				sizeToFit()
			}
		}
	}

	override var attributedText: NSAttributedString! {
		get {
			return super.attributedText
		}

		set {
			super.attributedText = newValue
			if autoresizeBasedOnTextLength {
				sizeToFit()
			}
			setNeedsDisplay()
		}
	}

	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		setupTextView()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupTextView()
	}

	private func setupTextView() {
		isScrollEnabled = false
		backgroundColor = .clear
		textContainer.lineBreakMode = .byWordWrapping
		contentMode = .redraw
		layoutManager.delegate = self
		textContainerInset = .zero
	}


	private func drawTape() {
		guard let tapeColor = tapeColor else {
			return
		}

		let range = layoutManager.glyphRange(for: textContainer)
		layoutManager.enumerateLineFragments(forGlyphRange: range) { [weak self] (_, usedRect, _, glyphRange, _) in
			guard let _self = self else {
				return
			}

			let currentStringFromGlyphRange = _self.textStorage.attributedSubstring(from: glyphRange).string
			guard !currentStringFromGlyphRange.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
				return
			}

			var glyphRect = usedRect
			_self.sanitize(rect: &glyphRect, for: glyphRange, string: currentStringFromGlyphRange)

			let path = UIBezierPath()

			let height = glyphRect.maxY - glyphRect.minY // the height of the rect
			let q = height * _self.heightFactor // the new height with the height factor

			let sinAlpha = sin(_self.degrees.toRadiants)
			let sinAlphaMinus90 = sin(CGFloat(90).toRadiants - _self.degrees.toRadiants)
			let xOffset = q * (sinAlpha / sinAlphaMinus90) // the x offset

			let p1 = CGPoint(x: glyphRect.minX, y: glyphRect.maxY)
			let p2 = CGPoint(x: glyphRect.minX + xOffset, y: glyphRect.maxY - q)
			let p3 = CGPoint(x: glyphRect.maxX + xOffset, y: glyphRect.maxY - q)
			let p4 = CGPoint(x: glyphRect.maxX , y: glyphRect.maxY)

			path.move(to: p1)
			path.addLine(to: p2)

			path.addLine(to: p3)
			path.addLine(to: p4)

			// Close the path. This will create the last line automatically.
			path.close()
			tapeColor.setFill()
			path.fill()
		}
	}

	private func sanitize(rect: inout CGRect,for glyphRange: NSRange,string currentStringFromGlyphRange: String){
		guard currentStringFromGlyphRange.last == " " else {
			return
		}
		let spaceWidth = layoutManager.boundingRect(forGlyphRange: NSRange(location: glyphRange.upperBound - 1, length: 1), in: textContainer).size.width
		rect.size.width -= spaceWidth
	}

	override func draw(_ rect: CGRect) {
		super.draw(rect)
		drawTape()
	}

	public func layoutManager(
		_ layoutManager: NSLayoutManager,
		shouldSetLineFragmentRect lineFragmentRect: UnsafeMutablePointer<CGRect>,
		lineFragmentUsedRect: UnsafeMutablePointer<CGRect>,
		baselineOffset: UnsafeMutablePointer<CGFloat>,
		in textContainer: NSTextContainer,
		forGlyphRange glyphRange: NSRange) -> Bool {

		let isFirstLine = glyphRange.lowerBound == 0
		let offset = isFirstLine ? 0 : lineSpacing
		lineFragmentRect.pointee.origin.y += offset
		lineFragmentUsedRect.pointee.origin.y += offset
		return true
	}
}

let vc = UIViewController()
vc.view.backgroundColor = .white
let sistemFont = UIFont.systemFont(ofSize: 36, weight: .bold)

func createTapeView(frame: CGRect, text: String, font: UIFont, color: UIColor, autoResize: Bool) -> TapeTextView {
	let tapeView = TapeTextView(frame: frame)
	tapeView.attributedText = NSAttributedString(string: text, attributes: [.font: font])
	tapeView.tapeColor = color
	tapeView.autoresizeBasedOnTextLength = autoResize
	vc.view.addSubview(tapeView)
	return tapeView
}

func createTapeViewWithAutolayout(text: String, font: UIFont, color: UIColor) -> TapeTextView {
	let tapeView = TapeTextView()
	tapeView.translatesAutoresizingMaskIntoConstraints = false
	vc.view.addSubview(tapeView)

	tapeView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
	tapeView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true

	tapeView.attributedText = NSAttributedString(string: text, attributes: [.font: font])
	tapeView.tapeColor = color
	return tapeView
}

let frame = CGRect(x: 30, y: 60, width: 250, height: 30)

/*
	Comment either createTapeView with autoResize on or with autoresize off
*/

//createTapeView(frame: frame, text: "This is a text to test this new feature", font: sistemFont, color: .green, autoResize: false)

createTapeView(frame: frame, text: "This is a text to test this new feature", font: sistemFont, color: UIColor(red: 0.816, green: 0.075, blue: 0.271, alpha: 1.0), autoResize: true)

createTapeViewWithAutolayout(text: "Create a marker\npen effect using\nTapeTextView", font: sistemFont, color: UIColor(red: 0.0, green: 0.667, blue: 0.357, alpha: 1.0))

PlaygroundPage.current.liveView = vc
