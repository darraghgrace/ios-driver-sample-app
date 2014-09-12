//
//  PPNRootViewController.m
//  SportsBook
//
//

#import "PPNRootViewController.h"
#import "PPNNavigationBarViewController.h"


@interface PPNRootViewController () <UIScrollViewDelegate> {
    
    BOOL _isTopTrackingScrollViewLoaded;
}


@property (weak, nonatomic) IBOutlet UIView *rootContainerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainContainerViewLeadingLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIView *mainContainerOverlayView;

@property (weak, nonatomic) IBOutlet UIScrollView *topTrackingScrollView;
@property (weak, nonatomic) IBOutlet UIView *topTrackingScrollViewSizingView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTrackingScrollViewSizingViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContainerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *topOverlayView;

@end


NSString *const PPNRootViewControllerRightContentViewDidAppearNotification = @"PPNRootViewControllerRightContentViewDidAppearNotification";
NSString *const PPNRootViewControllerRightContentViewDidDisappearNotification = @"PPNRootViewControllerRightContentViewDidDisappearNotification";

@implementation PPNRootViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.rootContainerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"curtainbg"]]];
    
    [self.topTrackingScrollView setDecelerationRate:UIScrollViewDecelerationRateFast];
    [self.topTrackingScrollView setHidden:YES];
    [self.topNavigationView addGestureRecognizer:[self.topTrackingScrollView panGestureRecognizer]];
    
    [self applySizingConstraintsToTopTrackingScrollView];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self layoutTopTrackingScrollView];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"PPNMainContentEmbed"]) {
        
        [self setMainContentViewController:[segue destinationViewController]];
    }
    else if ([[segue identifier] isEqualToString:@"PPNTopNavigationEmbed"]) {
        
        PPNNavigationBarViewController *navigationBarViewController = [segue destinationViewController];
        
        [self setTopNavigationViewController:navigationBarViewController];
        [navigationBarViewController setRootViewController:self];
    }
    else if ([[segue identifier] isEqualToString:@"PPNTopContentEmbed"]) {
        
        [self setTopContentViewController:[segue destinationViewController]];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

    
    [self.topTrackingScrollView setContentOffset:[self contentOffsetForNavigationBarState:PPNNavigationBarClosed] animated:NO];
}


#pragma mark - Show/Hide Views

- (PPNNavigationBarState)topNavigationViewState {
    
    CGPoint currentContentOffset = [self.topTrackingScrollView contentOffset];
    CGPoint favouritesOpenContentOffset = [self contentOffsetForNavigationBarState:PPNNavigationBarFavoritesOpen];
    CGPoint closedContentOffset = [self contentOffsetForNavigationBarState:PPNNavigationBarClosed];
    
    if (currentContentOffset.y < favouritesOpenContentOffset.y) {
        return PPNNavigationBarAtoZOpen;
    }
    else if (currentContentOffset.y < closedContentOffset.y) {
        return PPNNavigationBarFavoritesOpen;
    }
    
    return PPNNavigationBarClosed;
}

- (void)setTopNavigationViewState:(PPNNavigationBarState)state {
    
    [self setTopNavigationViewState:state animated:NO];
}

- (void)setTopNavigationViewState:(PPNNavigationBarState)state animated:(BOOL)animated {
    
    if (state != [self topNavigationViewState]) {
        
        CGPoint targetOffset = [self contentOffsetForNavigationBarState:state];
        
        [self.topTrackingScrollView setContentOffset:targetOffset animated:animated];
    }
}

#pragma mark - Convenience Methods

- (void)applySizingConstraintsToTopTrackingScrollView {
    
    UIView *sizingView = [self topTrackingScrollViewSizingView];
    UIView *topTrackingScrollView = [self topTrackingScrollView];
    
    NSLayoutConstraint *doubleHeightConstraint = [NSLayoutConstraint constraintWithItem:sizingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:topTrackingScrollView attribute:NSLayoutAttributeHeight multiplier:2.f constant:0.f];
    
    [topTrackingScrollView removeConstraint:[self topTrackingScrollViewSizingViewHeightConstraint]];
    [topTrackingScrollView addConstraint:doubleHeightConstraint];
}

- (void)layoutTopTrackingScrollView {
    
    if (!_isTopTrackingScrollViewLoaded && !CGSizeEqualToSize([[self topTrackingScrollView] contentSize], CGSizeZero)) {
        CGPoint initialContentOffset = [self maximumContentOffsetForScrollView:[self topTrackingScrollView]];
        [self.topTrackingScrollView setContentOffset:initialContentOffset animated:NO];
        _isTopTrackingScrollViewLoaded = YES;
    }
}

- (CGPoint)maximumContentOffsetForScrollView:(UIScrollView *)scrollView {

    CGRect scrollViewFrame = [scrollView frame];
    CGSize scrollViewContentSize = [scrollView contentSize];
    
    CGPoint maximumContentOffset = CGPointMake(MAX(scrollViewContentSize.width - scrollViewFrame.size.width, 0), MAX(scrollViewContentSize.height - scrollViewFrame.size.height, 0));
    
    return maximumContentOffset;
}

- (CGPoint)contentOffsetForNavigationBarState:(PPNNavigationBarState)state {
    
    CGPoint contentOffset;
    UIScrollView *scrollView = [self topTrackingScrollView];
    CGPoint maximumContentOffset = [self maximumContentOffsetForScrollView:scrollView];
    
    if (state == PPNNavigationBarClosed) {
        contentOffset = maximumContentOffset;
    }
    else if (state == PPNNavigationBarFavoritesOpen) {
        contentOffset = CGPointMake(0, maximumContentOffset.y - 110.f);
    }
    else if (state == PPNNavigationBarClosed) {
        contentOffset = CGPointZero;
    }
    else {
        contentOffset = CGPointZero;
    }

    return contentOffset;
}



- (void)updateNavigationBarArrowRotation {
    
    CGPoint maximumContentOffset = [self maximumContentOffsetForScrollView:[self topTrackingScrollView]];
    
    CGPoint contentOffset = [self.topTrackingScrollView contentOffset];
    CGPoint favouritesOpenContentOffset = [self contentOffsetForNavigationBarState:PPNNavigationBarFavoritesOpen];
    
    CGPoint contentOffsetInverted = CGPointMake(maximumContentOffset.x - contentOffset.x, maximumContentOffset.y - contentOffset.y);
    CGPoint favouritesOpenContentOffsetInverted = CGPointMake(maximumContentOffset.x - favouritesOpenContentOffset.x, maximumContentOffset.y - favouritesOpenContentOffset.y);
    
    CGFloat percentageScrolled = contentOffsetInverted.y / favouritesOpenContentOffsetInverted.y;
    CGFloat rotationAngle = M_PI * MIN(percentageScrolled, 1);
    
    [self.topNavigationViewController setArrowViewRotation:rotationAngle];
}


#pragma mark - Events

- (IBAction)topOverlayViewSingleTapRecognized:(id)sender {
    
    [self setTopNavigationViewState:PPNNavigationBarClosed animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
 
    [self performLayoutForTopTrackingScrollView];


}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGPoint expectedContentOffset = *targetContentOffset;
    
    if (scrollView == [self topTrackingScrollView]) {
        
        CGPoint maximumContentOffset = [self maximumContentOffsetForScrollView:scrollView];
        
        CGPoint closedContentOffset = [self contentOffsetForNavigationBarState:PPNNavigationBarClosed];
        CGPoint favouritesContentOffset = [self contentOffsetForNavigationBarState:PPNNavigationBarFavoritesOpen];
        CGPoint aToZContentOffset = [self contentOffsetForNavigationBarState:PPNNavigationBarAtoZOpen];
        
        CGFloat absoluteVelocity = velocity.x + velocity.y;
        
        CGFloat halfwayPointBetweenClosedAndFavoritesOpen = (favouritesContentOffset.y + ((closedContentOffset.y - favouritesContentOffset.y) / 2));
        CGFloat halfwayPointBetweenFavoritesOpenAndAToZOpen = (aToZContentOffset.y + ((favouritesContentOffset.y - aToZContentOffset.y) / 2));
        
        PPNNavigationBarState currentNavigationBarState = [self topNavigationViewState];
        
        CGFloat weakDragThreshold = 0.05f;
        CGFloat strongerDragThreshold = 2.f;
        
        if (absoluteVelocity < (0 - weakDragThreshold)) {
            
            if (ABS(absoluteVelocity) >= weakDragThreshold && ABS(absoluteVelocity) < strongerDragThreshold) {
                
                if (currentNavigationBarState == PPNNavigationBarAtoZOpen) {
                    *targetContentOffset = CGPointZero;
                }
                else if (currentNavigationBarState == PPNNavigationBarFavoritesOpen) {
                    *targetContentOffset = favouritesContentOffset;
                }
                else {
                    *targetContentOffset = maximumContentOffset;
                }
            }
            else if (ABS(absoluteVelocity) >= strongerDragThreshold) {
                *targetContentOffset = CGPointZero;
            }
        }
        else if (absoluteVelocity > (0 + weakDragThreshold)) {
            
            if (ABS(absoluteVelocity) >= weakDragThreshold && ABS(absoluteVelocity) < strongerDragThreshold) {
                
                if (currentNavigationBarState == PPNNavigationBarAtoZOpen) {
                    *targetContentOffset = favouritesContentOffset;
                }
                else if(currentNavigationBarState == PPNNavigationBarFavoritesOpen) {
                    *targetContentOffset = maximumContentOffset;
                }
                else {
                    *targetContentOffset = maximumContentOffset;
                }
            }
            else if(ABS(absoluteVelocity) >= strongerDragThreshold) {
                *targetContentOffset = maximumContentOffset;
            }
        }
        else if (ABS(absoluteVelocity) < weakDragThreshold) {
            
            if (expectedContentOffset.y >= halfwayPointBetweenClosedAndFavoritesOpen) {
                *targetContentOffset = maximumContentOffset;
            }
            else if (expectedContentOffset.y >= halfwayPointBetweenFavoritesOpenAndAToZOpen &&  expectedContentOffset.y <halfwayPointBetweenClosedAndFavoritesOpen) {
                *targetContentOffset = favouritesContentOffset;
            }
            else if (expectedContentOffset.y <= halfwayPointBetweenFavoritesOpenAndAToZOpen) {
                *targetContentOffset = CGPointZero;
            }
            else if (currentNavigationBarState == PPNNavigationBarClosed) {
                *targetContentOffset = maximumContentOffset;
            }
            else if(currentNavigationBarState == PPNNavigationBarFavoritesOpen) {
                *targetContentOffset = favouritesContentOffset;
            }
            else if (currentNavigationBarState == PPNNavigationBarAtoZOpen){
                *targetContentOffset = CGPointZero;
            }
        }
    }
}


#pragma mark - Tracking Layout

- (void)performLayoutForTopTrackingScrollView {
    
    UIScrollView *scrollView = [self topTrackingScrollView];
    
    CGPoint contentOffset = [scrollView contentOffset];
    CGPoint maximumContentOffset = [self maximumContentOffsetForScrollView:scrollView];
    CGPoint invertedContentOffset = CGPointMake(maximumContentOffset.x - contentOffset.x, maximumContentOffset.y - contentOffset.y);
    CGFloat topContainerViewOffset = invertedContentOffset.y;
    
    [self.topContainerViewHeightConstraint setConstant:topContainerViewOffset + kTopContainerInitialHeight];
    
    if (topContainerViewOffset > 0) {
        
        [self.topOverlayView setHidden:NO];
        [self.topNavigationViewController setBarButtonsHidden:YES animated:NO];
    }
    else {
        
        
        [self.topOverlayView setHidden:YES];
        [self.topNavigationViewController setBarButtonsHidden:NO animated:NO];
    }
    
    [self updateNavigationBarArrowRotation];
}

@end
