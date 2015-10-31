#import "GVModalDatePickerView.h"

@interface GVModalDatePickerView ()

@property (nonatomic, weak) IBOutlet UIView *backView;
@property (nonatomic, weak) IBOutlet UIView *contView;

@end


@implementation GVModalDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self    = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                            owner:nil
                                           options:nil] firstObject];
    if (self)
    {
        self.frame = frame;
        [self __init];
    } else {
        self = [super initWithFrame:frame];
        if (self)
        {
            self.frame = frame;
            [self __init];
        }
    }
    return self;
}

- (void)__init
{
    self.backgroundView         = self.backView;
    self.contentView            = self.contView;
}

#pragma mark \
overload

- (NSTimeInterval)duration
{
    return 0.25f;
}

#pragma mark \
actions

- (IBAction)done:(id)sender
{
    if (self.completionHandler != nil) {
        self.completionHandler(self.datePicker.date);
    }
}

- (IBAction)cancel:(id)sender
{
    if (self.cancelHandler != nil) {
        self.cancelHandler();
    }
}

@end
