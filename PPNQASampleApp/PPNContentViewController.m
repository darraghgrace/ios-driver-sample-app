//
//  PPNContentViewController.m
//  PPNQASampleApp
//
//
//

#import "PPNContentViewController.h"
#import "PPNMultiLevelContainerControllerViewController.h"

@interface PPNContentViewController ()

@end

@implementation PPNContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[_longTapView addGestureRecognizer:[[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)]];

    
    self.pinchDescription.adjustsFontSizeToFitWidth = TRUE;
    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    
    for (int i=[self.swipeView.scrollView.gestureRecognizers count]-1; i>0; i--) {
        UIGestureRecognizer *thisGestureRecognizer = [self.swipeView.scrollView.gestureRecognizers objectAtIndex:i];
        [self.swipeView.scrollView removeGestureRecognizer:thisGestureRecognizer];
    }
    
    [self.swipeView addGestureRecognizer:left];
    [self.swipeView addGestureRecognizer:right];
    [self.swipeView addGestureRecognizer:up];
    [self.swipeView addGestureRecognizer:down];
    
    for (int i=[self.pinchView.scrollView.gestureRecognizers count]-1; i>0; i--) {
        UIGestureRecognizer *thisGestureRecognizer = [self.pinchView.scrollView.gestureRecognizers objectAtIndex:i];
        [self.pinchView.scrollView removeGestureRecognizer:thisGestureRecognizer];
    }
    
    NSLog(@"%@", self.pinchView.scrollView.gestureRecognizers);
    [self.pinchView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)]];
//    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
//                                                          initWithTarget:self action:@selector(handleDoubleTap:)];
//    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
//    [_doubleTapView addGestureRecognizer:doubleTapGestureRecognizer];

//    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
//                                                          initWithTarget:self action:@selector(handleSingleTap:)];
//    singleTapGestureRecognizer.numberOfTapsRequired = 1;
//    [singleTapGestureRecognizer requireGestureRecognizerToFail: doubleTapGestureRecognizer];
//    [_doubleTapView addGestureRecognizer:singleTapGestureRecognizer];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    int numberOfPagesInScrollview = 5;
    _horizontalScrollView.accessibilityIdentifier = @"Horizontal Name";
    _horizontalScrollView.accessibilityLabel = @"Horizontal Label";
    _horizontalScrollView.accessibilityValue = @"Horizontal Value";
    
    _verticalScrollView.accessibilityIdentifier = @"Vertical Name";
    _verticalScrollView.accessibilityLabel = @"Vertical Label";
    _verticalScrollView.accessibilityValue = @"Vertical Value";
    
    
    
    _horizontalScrollView.contentSize = CGSizeMake(_horizontalScrollView.frame.size.width*numberOfPagesInScrollview, _horizontalScrollView.frame.size.height);
    _verticalScrollView.contentSize = CGSizeMake(_verticalScrollView.frame.size.width, _verticalScrollView.frame.size.height*numberOfPagesInScrollview);

        for (int i=0;i<numberOfPagesInScrollview;i++) {
            
            UIView *viewToInsertHorizontal = [[UIView alloc]initWithFrame:CGRectMake(_horizontalScrollView.frame.size.width*i, 0, _horizontalScrollView.frame.size.width, _horizontalScrollView.frame.size.height)];
            UILabel *pagingLabelHorizontal = [[UILabel alloc]initWithFrame:CGRectMake(0,0,viewToInsertHorizontal.frame.size.width,viewToInsertHorizontal.frame.size.height)];
            pagingLabelHorizontal.text=[NSString stringWithFormat:@"Horizontal View %d", i + 1];
            pagingLabelHorizontal.textAlignment = NSTextAlignmentCenter;
            [viewToInsertHorizontal addSubview:pagingLabelHorizontal];
            [_horizontalScrollView addSubview:viewToInsertHorizontal];
            
            UIView *viewToInsertVertical = [[UIView alloc]initWithFrame:CGRectMake(0, _verticalScrollView.frame.size.height*i, _verticalScrollView.frame.size.width, _verticalScrollView.frame.size.height)];
            
            UILabel *pagingLabelVertical = [[UILabel alloc]initWithFrame:CGRectMake(0,0,viewToInsertVertical.frame.size.width,viewToInsertVertical.frame.size.height)];
            pagingLabelVertical.text=[NSString stringWithFormat:@"Vertical View %d", i + 1];
            pagingLabelVertical.textAlignment = NSTextAlignmentCenter;
            
            [viewToInsertVertical addSubview:pagingLabelVertical];
            
            [_verticalScrollView addSubview:viewToInsertVertical];
        }
}

- (void)incrementCounter {
    self.counter++;
}

- (IBAction)singleTap:(id)sender {
    _longTapDescriptionLabel.text = @"Single Tap";
    _longTapView.tintColor = [UIColor blueColor];
}

- (IBAction)crashApp:(id)sender {
    NSArray *hey = @[@"1",@"2"];
    
    for (int i =0; i < 5; i++) {
        NSString *string = [hey objectAtIndex:i];
    }
    

    
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.counter = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(incrementCounter) userInfo:nil repeats:YES];
//        _longTapView.backgroundColor = [UIColor redColor];
        _longTapView.tintColor = [UIColor redColor];
        _longTapDescriptionLabel.text = @"Active";
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        _longTapDescriptionLabel.text = [NSString stringWithFormat:@"Long pressed for %d seconds.", self.counter];
        _longTapView.backgroundColor = [UIColor lightGrayColor];
        [self.timer invalidate];
        
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)gesture {
    self.pinchDescription.text = [NSString stringWithFormat:@"scale: %.3f - velocity: %.3f",gesture.scale,gesture.velocity];
}

- (void)handleSwipe:(UISwipeGestureRecognizer*)gesture {
    NSLog(@"%@", gesture);
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        self.swipeDescription.text = @"Swiped Right";
    }
    else if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.swipeDescription.text = @"Swiped Left";
    }
    else if (gesture.direction == UISwipeGestureRecognizerDirectionDown) {
        self.swipeDescription.text = @"Swiped Down";
    }
    else if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
        self.swipeDescription.text = @"Swiped Up";
	}
}

- (IBAction)onTapMultiLevel:(id)sender {
    
    PPNMultiLevelContainerControllerViewController *multiLevelContainerViewController = [[PPNMultiLevelContainerControllerViewController alloc] initWithNibName:@"PPNMultiLevelContainerControllerViewController" bundle:nil];
    
    [self.navigationController pushViewController:multiLevelContainerViewController animated:YES];
}


//- (void)handleDoubleTap:(UITapGestureRecognizer *)gesture {
//    if (gesture.state == UIGestureRecognizerStateEnded) {
//        _doubleTapDescription.text = @"Double Tap";
//        _doubleTapView.backgroundColor = [UIColor greenColor];
//    }
//}

@end
