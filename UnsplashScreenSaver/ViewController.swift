
import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "HH:mm"

        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // When we first load update the label with the current time.

        self.updateTime()

        // Then every second update the label with the time.
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in

            self.updateTime()
        }

        Unsplash.getRandom { json in
            guard let json = json,
                let urls = (json as? [String: Any])?["urls"],
                let reg  = (urls as? [String: Any])?["regular"] as? String
                else {
                    print("We got unexpected JSON")
                    return
            }

            let url = URL(string: reg)!
            let resource = ImageResource(downloadURL: url)
            
            self.imageView.kf.setImage(with: resource)
        }
    }

    func updateTime() {
        let time = Date()
        self.timeLabel.text = ViewController.dateFormatter.string(from: time)
    }
}

