//
//  PPNTableViewController.m
//  PPNQASampleApp
//
//
//

#import "PPNTableViewController.h"

@interface PPNTableViewController ()

@end

static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

@implementation PPNTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableData = [@[] mutableCopy];
    
    
    for (NSInteger count = 0; count < 10001; count++) {
        [self.tableData addObject:[self creatRandomStringofLength:50]];  //[self creatRandomStringofLength:30]
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [self colourForBackground:(indexPath.row % 2)];
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
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


- (NSString *)creatRandomStringofLength:(NSInteger )len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}
@end
