

import UIKit

struct RandomColor {
    
    private let colors: [UIColor] = [.red , .blue  , .darkGray , .orange , .brown , .purple]
    private var currentColor: UIColor = UIColor()
    
    public var color: UIColor {
        return currentColor
    }
    
    init() {
        currentColor = colorRandom()
    }
    
    
    private func colorRandom() -> UIColor{
        
        let index = Int.random(in: 0..<colors.count)
        return colors[index]
    }
    
}
