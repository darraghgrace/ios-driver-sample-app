//
//  PPNNavigationBarViewController.h
//  SportsBook
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class PPNRootViewController;

@interface PPNNavigationBarViewController : UIViewController

@property (weak, nonatomic) PPNRootViewController *rootViewController;
@property (assign, nonatomic, getter=isBarButtonsHidden) BOOL barButtonsHidden;

- (void)setBarButtonsHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setArrowViewRotation:(CGFloat)angle;

@end
