//
//  PPNTableViewController.h
//  PPNQASampleApp
//
//
//

#import <UIKit/UIKit.h>

@interface PPNTableViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;

@end
