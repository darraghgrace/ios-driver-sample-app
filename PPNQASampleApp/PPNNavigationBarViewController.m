//
//  PPNNavigationBarViewController.m
//  SportsBook
//
//

#import "PPNNavigationBarViewController.h"
#import "PPNRootViewController.h"

@interface PPNNavigationBarViewController ()


@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) NSArray *leftBarButtonItems;
@property (strong, nonatomic) NSArray *rightBarButtonItems;

@property (weak, nonatomic) IBOutlet UIImageView *centreTabImageView;

@property (weak, nonatomic) IBOutlet UIView *arrowView;

@end


@implementation PPNNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBarButtonItems:[[self.navigationBar topItem] leftBarButtonItems]];
    [self setRightBarButtonItems:[[self.navigationBar topItem] rightBarButtonItems]];
    
    UIImage *centreTabImage = [[UIImage imageNamed:@"headertab"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self.centreTabImageView setImage:centreTabImage];

     
      self.navigationBar.accessibilityLabel = @"At0ZnavigationBar";
    self.centreTabImageView.accessibilityLabel =  @"centreTabImageView";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Show/Hide Bar Buttons

- (void)setBarButtonsHidden:(BOOL)hidden {
    
    [self setBarButtonsHidden:hidden animated:NO];
}

- (void)setBarButtonsHidden:(BOOL)hidden animated:(BOOL)animated {
    
    _barButtonsHidden = hidden;
    
    if (hidden) {
        
        UINavigationItem *navigationItem = [self.navigationBar topItem];
        
        if ([navigationItem leftBarButtonItems] != nil || [navigationItem rightBarButtonItems] != nil) {
            
            [self setLeftBarButtonItems:[navigationItem leftBarButtonItems]];
            [self setRightBarButtonItems:[navigationItem rightBarButtonItems]];
            
            [navigationItem setLeftBarButtonItems:nil animated:animated];
            [navigationItem setRightBarButtonItems:nil animated:animated];
        }
    }
    else {
        
        UINavigationItem *navigationItem = [self.navigationBar topItem];
        
        [navigationItem setLeftBarButtonItems:[self leftBarButtonItems] animated:animated];
        [navigationItem setRightBarButtonItems:[self rightBarButtonItems] animated:animated];
    }
}


#pragma mark - Arrow View

- (void)setArrowViewRotation:(CGFloat)angle {
    
    [_arrowView.layer setAffineTransform:CGAffineTransformMakeRotation(angle)];
}


#pragma mark - Events

- (IBAction)centreMenuButtonPressed:(id)sender {
    
    if ([self.rootViewController topNavigationViewState] == PPNNavigationBarClosed) {
        [self.rootViewController setTopNavigationViewState:PPNNavigationBarFavoritesOpen animated:YES];
    }
    else {
        [self.rootViewController setTopNavigationViewState:PPNNavigationBarClosed animated:YES];
    }
}


@end
