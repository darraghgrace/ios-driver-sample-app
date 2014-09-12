//
//  PPNRootViewController.h
//  SportsBook
//
//

#import <UIKit/UIKit.h>

enum PPNNavigationBarState {
    
    PPNNavigationBarClosed = 0,
    PPNNavigationBarFavoritesOpen = 1,
    PPNNavigationBarAtoZOpen = 2
};
typedef enum PPNNavigationBarState PPNNavigationBarState;


#define kTopContainerInitialHeight 56.f
#define kRightContainerInitialOffset -256.f

NSString *const PPNRootViewControllerRightContentViewDidAppearNotification;
NSString *const PPNRootViewControllerRightContentViewDidDisappearNotification;

@class PPNNavigationBarViewController;
@class PPNCurtainNavigationViewController;

@interface PPNRootViewController : UIViewController 


@property (weak, nonatomic) IBOutlet UIView *mainContainerView;

@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) UIViewController *mainContentViewController;

@property (weak, nonatomic) IBOutlet UIView *topNavigationView;
@property (weak, nonatomic) PPNNavigationBarViewController *topNavigationViewController;

@property (weak, nonatomic) IBOutlet UIView *topContentView;
@property (weak, nonatomic) UIViewController *topContentViewController;


@property (assign, nonatomic) PPNNavigationBarState topNavigationViewState;

- (void)setTopNavigationViewState:(PPNNavigationBarState)state animated:(BOOL)animated;

@end
