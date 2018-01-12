import UIKit
import DateToolsSwift

open class Event: EventDescriptor {
  public var isNewEvent: Bool = false
  public var datePeriod = TimePeriod()
  public var text = ""
  public var attributedText: NSAttributedString?
  public var color = UIColor.blue {
    didSet {
      backgroundColor = color.withAlphaComponent(0.3)
      var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
      color.getRed(&r, green: &g, blue: &b, alpha: &a)
      textColor = UIColor(red: max(r - 0.3, 0), green: max(g - 0.3, 0), blue: max(b - 0.3, 0), alpha: a)
      /*
      var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
      color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
      textColor = UIColor(hue: h, saturation: s, brightness: b * 0.4, alpha: a)
      */
    }
  }
  public var backgroundColor = UIColor.blue.withAlphaComponent(0.3)
  public var textColor = UIColor.black
  public var font = UIFont.boldSystemFont(ofSize: 12)
  public var frame = CGRect.zero
  public var userInfo: Any?
  public init() {}
}
