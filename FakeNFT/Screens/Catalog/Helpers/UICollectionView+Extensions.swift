import UIKit

extension UICollectionView {
    struct Config {
        let cellCount: CGFloat
        let leftInset: CGFloat
        let rightInset: CGFloat
        let topInset: CGFloat
        let bottomInset: CGFloat
        let height: CGFloat
        let cellSpacing: CGFloat
        var paddingWidth: CGFloat {
            leftInset + rightInset + CGFloat(cellCount - 1) * cellSpacing
        }
    }
}
