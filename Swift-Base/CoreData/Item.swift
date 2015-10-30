@objc(Item)
class Item: _Item {

    override func awakeFromInsert() {
        super.awakeFromInsert()
        let itemWithMaxOrder = Item.MR_findFirstOrderedByAttribute(ItemAttributes.order.rawValue, ascending: false)
        let maxIndex = itemWithMaxOrder.order?.intValue
        self.order = NSNumber(int: maxIndex! + 1)
    }

}
