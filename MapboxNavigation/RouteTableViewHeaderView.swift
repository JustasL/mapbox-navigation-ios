import UIKit

protocol RouteTableViewHeaderViewDelegate: class {
    func didTapCancel()
}
//This could be final
@IBDesignable
class RouteTableViewHeaderView: UIView {
    //Some of these could be private
    @IBOutlet weak var progressBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var progressBar: ProgressBar! //Why did progressBar had outlet, even though was not used?
    @IBOutlet weak var distanceRemaining: SubtitleLabel!
    @IBOutlet weak var timeRemaining: TitleLabel!
    @IBOutlet weak var etaLabel: TitleLabel!
    @IBOutlet weak var dividerView: SeparatorView!
    
    weak var delegate: RouteTableViewHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //clear default values from the storyboard so user does not see a 'flash' of random values
        distanceRemaining.text = ""
        timeRemaining    .text = ""
        etaLabel         .text = ""
        
        //Don't care, just hide it (because sometimes progress bar 'unloads')
        //TODO: Investigate why modified steps have odd behaviour
        progressBar      .isHidden = true
        distanceRemaining.isHidden = true
        timeRemaining    .isHidden = true
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: bounds.width, height: 80)
        }
    }
    
    // Set the progress between 0.0-1.0
    @IBInspectable
    var progress: CGFloat = 0 {
        didSet {
            if (progressBarWidthConstraint != nil) {
                progressBarWidthConstraint.constant = bounds.width * progress
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.layoutIfNeeded()
                }
            }
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        delegate?.didTapCancel()
    }
}
