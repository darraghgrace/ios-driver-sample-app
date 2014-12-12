//
//  PPNMultiLevelContainerControllerViewController.m
//  PPNQASampleApp
//
//  Created by Villette, Stephane on 11/12/2014.
//
//

#define kPPNMultiLevelContainerCellReuseId @"PPNMultiLevelContainerCellReuseId"

#import "PPNMultiLevelContainerControllerViewController.h"
#import "PPNMultiLevelCollectionViewCell.h"

@interface PPNMultiLevelContainerControllerViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation PPNMultiLevelContainerControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.decelerationRate = 0.5;
    
    [self.collectionView registerClass:[PPNMultiLevelCollectionViewCell class] forCellWithReuseIdentifier:kPPNMultiLevelContainerCellReuseId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDataSource/UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PPNMultiLevelCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kPPNMultiLevelContainerCellReuseId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(872, 630);
}

@end
