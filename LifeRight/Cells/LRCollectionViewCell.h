//
//  LRCollectionViewCell.h
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LRCellContent;

@interface LRCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIView *avatarView;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *contentImageView;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIView *authorLabelContainerView;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;

@property (strong, nonatomic) IBOutlet UIView *sentInfoViewContainer;
@property (strong, nonatomic) IBOutlet UIView *hashedLineView;
@property (strong, nonatomic) IBOutlet UILabel *postedTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *viaLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sourceImageView;

@property (strong, nonatomic) LRCellContent *content;

- (void)setupWithContent:(LRCellContent*)contentObject;
- (void)resizeToFitContent;
+ (CGSize)predictSizeForContent:(LRCellContent*)content;

@end
