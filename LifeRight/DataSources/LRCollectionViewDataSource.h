//
//  LRCollectionViewDataSource.h
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRCollectionViewDataSource : NSObject<UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) NSArray *ads;

- (void)getCurrentTimeLine;

@end
