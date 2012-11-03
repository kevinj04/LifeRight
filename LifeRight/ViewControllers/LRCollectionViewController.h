//
//  LRCollectionViewController.h
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRCollectionViewDataSource.h"

@interface LRCollectionViewController : UICollectionViewController

@property (strong, nonatomic) LRCollectionViewDataSource *dataSource;

@end
