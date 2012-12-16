//
//  LRCollectionViewDataSource.h
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRCollectionViewDataSource : NSObject<UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *contentStream;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) NSMutableArray *ads;

- (CGSize)sizeForCellAtIndexPath:(NSIndexPath*)indexPath;
- (void)updateContentStreamWithContent:(NSArray*)contentArray;
- (void)gatherContentStream;
- (void)getCurrentTimeLine;
- (void)getAds;

@end
