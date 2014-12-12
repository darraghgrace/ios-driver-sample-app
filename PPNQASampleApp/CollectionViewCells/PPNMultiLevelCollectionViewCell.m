//
//  PPNMultiLevelCollectionViewCell.m
//  PPNQASampleApp
//
//  Created by Villette, Stephane on 11/12/2014.
//
//

#import "PPNMultiLevelCollectionViewCell.h"
#import "PPNMultiLevelTableViewController.h"
#import "PPNMultiLevelTableViewCell.h"

#define kMultipleLevelsCellReuseID @"MultipleLevelsCellReuseID"

@interface PPNMultiLevelCollectionViewCell()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation PPNMultiLevelCollectionViewCell

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    
    if (self){
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 800, 800)];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.allowsSelection = NO;
    
    self.tableData = [@[] mutableCopy];
    
    for (NSInteger count = 0; count < 10; count++) {
        [self.tableData addObject:[NSNumber numberWithInteger:count]];
    }
    
    UINib *multipleLevelsCellNib = [UINib nibWithNibName:NSStringFromClass([PPNMultiLevelTableViewCell class]) bundle:nil];
    [self.tableView registerNib:multipleLevelsCellNib forCellReuseIdentifier:kMultipleLevelsCellReuseID];
    
    [self.tableView reloadData];
    
    [self.contentView addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMultipleLevelsCellReuseID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [self colourForBackground:(indexPath.row % 2)];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return
    self.tableData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
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

@end
