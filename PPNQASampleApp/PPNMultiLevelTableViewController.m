//
//  PPNMultiLevelTableViewController.m
//  PPNQASampleApp
//
//  Created by Villette, Stephane on 09/12/2014.
//
//

#import "PPNMultiLevelTableViewController.h"
#import "PPNMultiLevelTableViewCell.h"

#define kMultipleLevelsCellReuseID @"MultipleLevelsCellReuseID"

@interface PPNMultiLevelTableViewController()

@end

static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation PPNMultiLevelTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.allowsSelection = NO;
    
    self.tableData = [@[] mutableCopy];
    
    for (NSInteger count = 0; count < 10; count++) {
        [self.tableData addObject:[NSNumber numberWithInteger:count]];
    }
    
    UINib *multipleLevelsCellNib = [UINib nibWithNibName:NSStringFromClass([PPNMultiLevelTableViewCell class]) bundle:nil];
    [self.tableView registerNib:multipleLevelsCellNib forCellReuseIdentifier:kMultipleLevelsCellReuseID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMultipleLevelsCellReuseID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [self colourForBackground:(indexPath.row % 2)];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88.0f;
}

- (UIColor *)colourForBackground:(BOOL)odd {
    if (odd) {
        return [UIColor lightGrayColor];
    }
    else {
        return [UIColor whiteColor];
    }
}

- (IBAction)dismissViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}


@end
