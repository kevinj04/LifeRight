//
//  LRCollectionViewLayout.h
//  LifeRight
//
//  Created by Kevin Jenkins on 12/16/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRCollectionViewLayout : UICollectionViewLayout

@property int numberOfColumns;
@property CGFloat columnWidth;
@property CGFloat columnSpacing;
@property CGFloat verticalCellSpacing;

@property (strong, nonatomic) NSMutableDictionary *layoutInformation;
@property (strong, nonatomic) NSMutableArray *columnBottom;

@end
