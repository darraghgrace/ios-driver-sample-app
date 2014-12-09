//
//  PPNMultiLevelTableViewCell.m
//  PPNQASampleApp
//
//  Created by Villette, Stephane on 09/12/2014.
//
//

#import "PPNMultiLevelTableViewCell.h"

@interface PPNMultiLevelTableViewCell()

@property (nonatomic, strong) UIButton *level6Button;

@end

@implementation PPNMultiLevelTableViewCell

- (void)awakeFromNib {
    // Initialization code

    // Create multi level view
    UIView *subview1 = [self subviewInContainerView:self.contentView];
    
    subview1.backgroundColor = [UIColor redColor];
    UIView *subview2 = [self subviewInContainerView:subview1];
    subview2.backgroundColor = [UIColor blueColor];
    UIView *subview3 = [self subviewInContainerView:subview2];
    subview3.backgroundColor = [UIColor grayColor];
    UIView *subview4 = [self subviewInContainerView:subview3];
    subview4.backgroundColor = [UIColor blackColor];
    UIView *subview5 = [self subviewInContainerView:subview4];
    subview5.backgroundColor = [UIColor purpleColor];
    UIView *subview6 = [self subviewInContainerView:subview5];
    subview6.backgroundColor = [UIColor cyanColor];
    
    self.level6Button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.level6Button.backgroundColor = [UIColor grayColor];
    self.level6Button.titleLabel.textColor = [UIColor whiteColor];
    self.level6Button.frame = CGRectMake(300, 0, 200, 50);
    [self.level6Button setTitle:@"Level6" forState:UIControlStateNormal];
    [self.level6Button addTarget:self action:@selector(level6ButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [subview6 addSubview:self.level6Button];
}

-(void)level6ButtonTapped:(id)sender {
    NSLog(@"level6ButtonTapped");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIView*)subviewInContainerView:(UIView*)containerView {
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectZero];
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:subview];
    
    NSDictionary *views = @{ @"subview": subview };
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[subview]-(10)-|" options:0 metrics:nil views:views]];
    [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(3)-[subview]-(3)-|" options:0 metrics:nil views:views]];

    return subview;
}

@end
