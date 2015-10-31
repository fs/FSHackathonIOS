#import "GVModalView.h"

@interface GVModalPickerView : GVModalView

@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;

@property (nonatomic, copy) void(^completionHandler)();
@property (nonatomic, copy) void(^cancelHandler)();

@end
