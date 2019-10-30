import UIKit

protocol SketchDelegate: Sketch {
    func setup()
    func draw()
}

@IBDesignable class Sketch: UIView {
    weak var delegate: SketchDelegate?
    var rect: CGRect = CGRect()
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    override init(frame: CGRect){
        super.init(frame: frame);
        delegate = self as? SketchDelegate
        startAnimation()
    }
    
    required init(coder: NSCoder){
        super.init(coder: coder)!;
        delegate = self as? SketchDelegate
        startAnimation()
    }
    
    private func startAnimation(){
        Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in
            self?.setNeedsDisplay();
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.width = rect.width
        self.height = rect.height
        self.rect = rect
        delegate?.draw()
    }
    
}
