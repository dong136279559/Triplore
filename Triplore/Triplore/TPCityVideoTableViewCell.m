//
//  TPCityVideoTableViewCell.m
//  Triplore
//
//  Created by Sorumi on 17/6/2.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import "TPCityVideoTableViewCell.h"
#import "TPVideoCollectionViewCell.h"

@interface TPCityVideoTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;


@end

@implementation TPCityVideoTableViewCell

static NSString * const reuseIdentifier = @"TPVideoCollectionViewCell";


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"TPVideoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
 }

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TPVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.titleLabel.text = self.sites[indexPath.item];
    
    // Configure the cell
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    if([self.delegate respondsToSelector:@selector(didSelectSite:withMode:)]) {
//        NSLog(@"select %@", self.sites[indexPath.item]);
//        [self.delegate didSelectSite:self.sites[indexPath.item] withMode:self.mode];
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((CGRectGetWidth(self.collectionView.frame) - 10) / 2,
                      (CGRectGetWidth(self.collectionView.frame) - 10) / 2 / 16 * 9 + 55);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
