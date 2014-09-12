//
//  PPNContentViewController.h
//  PPNQASampleApp
//
//
//

#import <UIKit/UIKit.h>

@interface PPNContentViewController : UIViewController

//@property (weak, nonatomic) IBOutlet UIView *longTapView;

@property (weak, nonatomic) IBOutlet UIButton *longTapView;
@property (weak, nonatomic) IBOutlet UILabel *longTapDescriptionLabel;


@property (weak, nonatomic) IBOutlet UIWebView *swipeView;

//@property (weak, nonatomic) IBOutlet UIView *swipeView;
@property (weak, nonatomic) IBOutlet UILabel *swipeDescription;


@property (weak, nonatomic) IBOutlet UIWebView *pinchView;
//@property (weak, nonatomic) IBOutlet UIView *pinchView;
@property (weak, nonatomic) IBOutlet UILabel *pinchDescription;

@property (weak, nonatomic) IBOutlet UIScrollView *horizontalScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *verticalScrollView;


@property (nonatomic, strong) NSTimer *timer;
@property (assign) int counter;

@end
