#import "GVModalView.h"
#import "CAAnimation+Blocks.h"

@interface GVModalView()

@property (nonatomic, assign) BOOL isShow;

@end

@implementation GVModalView

@synthesize backgroundView = _backgroundView;

- (id)initWithFrame:(CGRect)frame
{
    self        = [super initWithFrame:frame];
    if (self)
    {
        [self __initialize];
    }
    return self;
}

- (void)__initialize
{

}

#pragma mark \
accessory

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (_backgroundView)
    {
        [_backgroundView removeFromSuperview];
        _backgroundView         = nil;
    }
    
    backgroundView.frame        = self.bounds;
    [self insertSubview:backgroundView
                atIndex:0];
    _backgroundView             = backgroundView;
}

- (void)setContentView:(UIView *)contentView
{
    if (_contentView)
    {
        [_contentView removeFromSuperview];
        _contentView         = nil;
    }
    
    contentView.frame        = self.bounds;
    [self insertSubview:contentView
                atIndex:1];
    _contentView             = contentView;
}

#pragma mark \
present and dissmis

- (void)showWithType:(GVModalViewShowType)type
          completion:(void (^)(BOOL))completion
{
    if (self.isShow)
    {
        return;
    }
    
    _isShow                                 = YES;
    __weak typeof(self) wself               = self;
    CGFloat duration                        = [self durationShow];
    
    UIViewController *rootViewController    = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    CGRect windowRect                       = rootViewController.view.bounds;
    self.frame                              = windowRect;
    self.backgroundView.frame               = windowRect;
    self.contentView.frame                  = windowRect;
    self.backgroundColor                    = [UIColor clearColor];
    self.autoresizingMask                   = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
#if (defined(__IPHONE_7_0))
    if ([self isUseMotionEffect])
    {
        [self __applyMotionEffects];
    }
#endif
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        {
            self.transform = CGAffineTransformMakeRotation(M_PI * 270.0 / 180.0);
        }; break;
            
        case UIInterfaceOrientationLandscapeRight:
        {
            self.transform = CGAffineTransformMakeRotation(M_PI * 90.0 / 180.0);
        }; break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            self.transform = CGAffineTransformMakeRotation(M_PI * 180.0 / 180.0);
        }; break;
            
        default:
            break;
    }
    
    [rootViewController.view resignFirstResponder];
    
    switch (type)
    {
        case GVModalViewShowTypeScale:
        {
            [self __prepareShowAnimation];
            
            self.backgroundView.alpha               = 0.0f;
            self.contentView.alpha                  = 0.0f;
            
            NSArray *values                         = @[@0.0, @1.05, @0.8, @1.02, @1.0];
            CAKeyframeAnimation *bounceAnimation    = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.xy"];
            bounceAnimation.values = values;
            [bounceAnimation setTimingFunctions:@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]]];
            bounceAnimation.duration                = duration;
            [bounceAnimation setCompletion:^(BOOL finished) {
                [wself __endedShowAnimation:finished
                                 completion:completion];
            }];
            [self.contentView.layer addAnimation:bounceAnimation
                                          forKey:nil];
            
            [UIView animateWithDuration:duration
                             animations:^{
                                 wself.backgroundView.alpha             = 1.0f;
                                 wself.contentView.alpha                = 1.0f;
                             }];
        }; break;
            
        case GVModalViewShowTypeCustom:
        {
            [self __prepareShowAnimation];
            
            [self customShow:^(BOOL finished) {
                [wself __endedShowAnimation:finished
                                 completion:completion];
            }];
        }; break;
            
        default:
        {
            [self __prepareShowAnimation];
            
            self.backgroundView.alpha               = 0.0f;
            self.contentView.alpha                  = 1.0f;
            self.contentView.frame                  = CGRectMake(windowRect.origin.x,
                                                                 windowRect.size.height,
                                                                 windowRect.size.width,
                                                                 windowRect.size.height);
            
            [UIView animateWithDuration:duration
                             animations:^{
                                 wself.backgroundView.alpha             = 1.0f;
                                 wself.contentView.frame                = windowRect;
                             } completion:^(BOOL finished) {
                                 [wself __endedShowAnimation:finished
                                                  completion:completion];
                             }];
        }; break;
    }
}

- (void)dismissWithType:(GVModalViewDismissType)type
             completion:(void (^)(BOOL))completion
{
    if (!self.isShow)
    {
        return;
    }
    
    _isShow                                 = NO;
    __weak typeof(self) wself               = self;
    CGFloat duration                        = [self durationDismiss];
    
    UIViewController *rootViewController    = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    CGRect windowRect                       = rootViewController.view.bounds;
    
    switch (type)
    {
        case GVModalViewDismissTypeScale:
        {
            [self __prepareDismissAnimation];
            
            [UIView animateWithDuration:duration
                             animations:^{
                                 wself.backgroundView.alpha             = 0.0f;
                                 wself.contentView.alpha                = 0.0f;
                             }];
            
            NSArray *values                             = @[@1.0, @1.05, @0.0];
            CAKeyframeAnimation *bounceAnimation        = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.xy"];
            bounceAnimation.values                      = values;
            [bounceAnimation setTimingFunctions:@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]]];
            bounceAnimation.duration                    = duration;
            [bounceAnimation setCompletion:^(BOOL finished)
             {
                 [wself __endedDismissAnimation:finished
                                     completion:completion];
             }];
            
            [self.contentView.layer addAnimation:bounceAnimation
                                          forKey:nil];
        }; break;
            
        case GVModalViewDismissTypeCustom:
        {
            [self __prepareDismissAnimation];
            
            [self customDismiss:^(BOOL finished) {
                [wself __endedDismissAnimation:finished
                                    completion:completion];
            }];
        }; break;
            
        default:
        {
            [self __prepareDismissAnimation];
            
            [UIView animateWithDuration:duration
                             animations:^{
                                 wself.backgroundView.alpha             = 0.0f;
                                 wself.contentView.frame                = CGRectMake(windowRect.origin.x,
                                                                                     windowRect.size.height,
                                                                                     windowRect.size.width,
                                                                                     windowRect.size.height);
                             } completion:^(BOOL finished) {
                                 [wself __endedDismissAnimation:finished
                                                     completion:completion];
                             }];
        }; break;
    }
}

- (NSTimeInterval)durationShow
{
    return 0.5f;
}

- (NSTimeInterval)durationDismiss
{
    return 0.5f;
}

#pragma mark \
custom show and dismiss

- (void)customShow:(void(^)(BOOL finished))completed
{
    NSAssert(false, @"%s not implemented", __FUNCTION__);
}

- (void)customDismiss:(void(^)(BOOL finished))completed
{
    NSAssert(false, @"%s not implemented", __FUNCTION__);
}

#if (defined(__IPHONE_7_0))

- (BOOL)isUseMotionEffect
{
    return NO;
}

#pragma mark \
private

- (void)__prepareShowAnimation
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)__endedShowAnimation:(BOOL)finished
                  completion:(void(^)(BOOL finished))completion
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    if (completion != nil) {
        completion(finished);
    }
}

- (void)__prepareDismissAnimation
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

- (void)__endedDismissAnimation:(BOOL)finished
                     completion:(void(^)(BOOL finished))completion
{
    [self removeFromSuperview];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    if (completion != nil) {
        completion(finished);
    }
}

// Add motion effects
- (void)__applyMotionEffects
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        return;
    }
    
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-10.0f);
    horizontalEffect.maximumRelativeValue = @(10.0f);
    
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-10.0f);
    verticalEffect.maximumRelativeValue = @(10.0f);
    
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [self.contentView addMotionEffect:motionEffectGroup];
}
#endif

@end
