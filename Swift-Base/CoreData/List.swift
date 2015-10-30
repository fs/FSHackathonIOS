@objc(List)
class List: _List {

    override func awakeFromInsert() {
        super.awakeFromInsert()
        self.date = NSDate.init()
    }

}
