import UIKit
import DateToolsSwift

public struct DayViewOptions {
  public var canScrollVerticallyWithinDay: Bool = true
  public var canScrollHorizontallyToSwitchDay: Bool = true
  
  public init() {}
}

open class DayViewController: UIViewController, EventDataSource, DayViewDelegate {
  
  var options = DayViewOptions()

  public lazy var dayView: DayView = DayView(withOptions: options)
  
  override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public init(withOptions options: DayViewOptions) {
    self.options = options
    super.init(nibName: nil, bundle: nil)
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    self.edgesForExtendedLayout = UIRectEdge()
    view.addSubview(dayView)
    view.tintColor = UIColor.red

    dayView.dataSource = self
    dayView.delegate = self
    dayView.reloadData()
  }

  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    dayView.scrollToFirstEventIfNeeded()
  }

  open override func viewDidLayoutSubviews() {
    dayView.fillSuperview()
  }

  open func reloadData() {
    dayView.reloadData()
  }

  open func updateStyle(_ newStyle: CalendarStyle) {
    dayView.updateStyle(newStyle)
  }

  open func eventsForDate(_ date: Date) -> [EventDescriptor] {
    return [Event]()
  }

  // MARK: DayViewDelegate

  open func dayViewDidSelectEventView(_ eventView: EventView) {

  }

  open func dayViewDidLongPressEventView(_ eventView: EventView) {

  }

  open func dayViewDidLongPressTimelineAtHour(_ hour: Int) {

  }

  open func dayView(dayView: DayView, willMoveTo date: Date) {
    print("DayView = \(dayView) will move to: \(date)")
  }

  open func dayView(dayView: DayView, didMoveTo date: Date) {
    print("DayView = \(dayView) did move to: \(date)")
  }
}
