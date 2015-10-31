#import "GVModalView.h"

@interface GVModalDatePickerView : GVModalView

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, copy) void(^completionHandler)(NSDate *date);
@property (nonatomic, copy) void(^cancelHandler)();

@end
