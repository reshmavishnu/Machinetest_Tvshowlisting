

import UIKit
import SDWebImage

protocol protocol_Cell_Poster {
    func passID()
}

class Cell_Poster: UICollectionViewCell {
    @IBOutlet weak var m_Image: UIImageView!
     @IBOutlet weak var m_Tit: UILabel!
    var delegate : protocol_Cell_Poster?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var nib: UINib {
        return UINib (nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String (describing: self)
    }
    
    var item: struct_EachtvShow? {
        didSet {
            guard let item = item else {
                return
            }
            self.m_Tit.text = item.name
            if let url =  item.image?.original {
                m_Image.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named:"img_Loader"))
            }
            else {
                self.m_Image.image = UIImage(named:"img_Loader")
            }
        }
    }
    
    var item1: struct_EachSearchedtvShow? {
           didSet {
               guard let item = item1 else {
                   return
               }
               self.m_Tit.text = item.name
               if let url =  item.image?.original {
                   m_Image.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named:"img_Loader"))
               }
               else {
                   self.m_Image.image = UIImage(named:"img_Loader")
               }
           }
       }
    
    @IBAction func btnAction_showDetail(_ sender : AnyObject) {
        self.delegate?.passID()
        
    }
    
}
