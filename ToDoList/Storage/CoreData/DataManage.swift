
import UIKit

final class DataManager {
    public static let shared = DataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init (){}
}
