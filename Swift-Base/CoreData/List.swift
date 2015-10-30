@objc(List)
class List: _List {

    override func awakeFromInsert() {
        super.awakeFromInsert()
        self.date = NSDate()
    }
    
    var minPrice: Int {
        var price: Double = 0
        
        for _listedItem in self.listedItems {
            let listedItem = _listedItem as! ListedItem
            price += listedItem.item!.minPrice!.doubleValue
        }
        
        return Int(price)
    }
    
    var maxPrice: Int {
        var price: Double = 0
        
        for _listedItem in self.listedItems {
            let listedItem = _listedItem as! ListedItem
            price += listedItem.item!.maxPrice!.doubleValue
        }
        
        return Int(price)
    }
    
}
