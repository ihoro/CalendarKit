import UIKit
import DateToolsSwift
import Neon

protocol EventViewDelegate: class {
  func eventViewDidTap(_ eventView: EventView)
  func eventViewDidLongPress(_ eventview: EventView)
}

public protocol EventDescriptor: class {
  var isNewEvent: Bool {get}
  var datePeriod: TimePeriod {get}
  var text: String {get}
  var attributedText: NSAttributedString? {get}
  var font : UIFont {get}
  var color: UIColor {get}
  var textColor: UIColor {get}
  var backgroundColor: UIColor {get}
  var frame: CGRect {get set}
}

open class EventView: UIView {

  weak var delegate: EventViewDelegate?
  public var descriptor: EventDescriptor?

  public var color = UIColor.lightGray

  var contentHeight: CGFloat {
    return textView.height
  }

  lazy var textView: UITextView = {
    let view = UITextView()
    view.isUserInteractionEnabled = false
    view.backgroundColor = .clear
    view.isScrollEnabled = false
    return view
  }()

  lazy var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
  lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }

  func configure() {
    clipsToBounds = true
    [tapGestureRecognizer, longPressGestureRecognizer].forEach {addGestureRecognizer($0)}

    color = tintColor
    addSubview(textView)
  }

  func updateWithDescriptor(event: EventDescriptor) {
    if let attributedText = event.attributedText {
      textView.attributedText = attributedText
    } else {
      textView.text = event.text
      textView.textColor = event.textColor
      textView.font = event.font
    }
    descriptor = event
    backgroundColor = event.backgroundColor
    color = event.color
    setNeedsDisplay()
    setNeedsLayout()
  }

  @objc func tap() {
    delegate?.eventViewDidTap(self)
  }

  @objc func longPress() {
    delegate?.eventViewDidLongPress(self)
  }

  override open func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let context = UIGraphicsGetCurrentContext() else { return }
    context.interpolationQuality = .none
    context.saveGState()
    context.setStrokeColor(color.cgColor)
    context.setLineWidth(3)
    context.translateBy(x: 0, y: 0.5)
    let x: CGFloat = 0
    let y: CGFloat = 0
    context.beginPath()
    context.move(to: CGPoint(x: x, y: y))
    context.addLine(to: CGPoint(x: x, y: (bounds).height))
    context.strokePath()

    // diagonal lines background pattern
    if descriptor != nil && descriptor!.isNewEvent {
      let T: CGFloat = 2     // desired thickness of lines
      let G: CGFloat = 4     // desired gap between lines
      let W = rect.size.width
      let H = rect.size.height
      
      context.setStrokeColor(UIColor(red:1, green:1, blue:1, alpha:0.3).cgColor)
      context.setLineWidth(T)
      
      var p = -(W > H ? W : H) - T
      while p <= W {
        context.move( to: CGPoint(x: p-T, y: -T) )
        context.addLine( to: CGPoint(x: p+T+H, y: T+H) )
        context.strokePath()
        p += G + T + T
      }
    }
    
    context.restoreGState()
  }

  override open func layoutSubviews() {
    super.layoutSubviews()
    textView.fillSuperview()
  }
}
