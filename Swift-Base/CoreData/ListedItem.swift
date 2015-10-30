@objc(ListedItem)
class ListedItem: _ListedItem {

    override func awakeFromInsert() {
        super.awakeFromInsert()
        self.date = NSDate()
    }

}
