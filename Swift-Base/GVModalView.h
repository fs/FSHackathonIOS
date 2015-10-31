#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GVModalViewShowType)
{
    GVModalViewShowTypeDefault,
    GVModalViewShowTypeScale,
    GVModalViewShowTypeCustom
};

typedef NS_ENUM(NSUInteger, GVModalViewDismissType)
{
    GVModalViewDismissTypeDefault,
    GVModalViewDismissTypeScale,
    GVModalViewDismissTypeCustom
};

@interface GVModalView : UIView

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, assign, readonly) BOOL isShow;

- (void)showWithType:(GVModalViewShowType)type
          completion:(void(^)(BOOL finished))completion;
- (void)dismissWithType:(GVModalViewDismissType)type
             completion:(void(^)(BOOL finished))completion;

- (NSTimeInterval)durationShow;
- (NSTimeInterval)durationDismiss;

- (void)customShow:(void(^)(BOOL finished))completed;
- (void)customDismiss:(void(^)(BOOL finished))completed;

#if (defined(__IPHONE_7_0))
- (BOOL)isUseMotionEffect;
#endif

@end
