//
//  GXGuideCollectionViewCell.h
//  JiaFan
//
//  Created by apple on 2017/3/22.
//  Copyright © 2017年 杜顺. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GXGuideCollectionViewCellDelegate <NSObject>

- (void)beginAction:(UIButton *)sender;

@end

@interface GXGuideCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *beginBtn;
@property (nonatomic, weak) id<GXGuideCollectionViewCellDelegate> delegate;

@end
