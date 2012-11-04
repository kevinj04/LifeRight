//
//  LRCollectionViewDataSource.m
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRCollectionViewDataSource.h"
#import "LRCollectionViewCell.h"
#import "LRTwitterAPI.h"

@implementation LRCollectionViewDataSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.tweets = [[NSMutableArray alloc] initWithCapacity:100];
        self.ads = [[NSMutableArray alloc] initWithCapacity:20];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource Delegate Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyCell" forIndexPath:indexPath];
    
    [cell setupWithDictionary:[self.tweets objectAtIndex:indexPath.row]];

    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tweets.count + self.ads.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


#pragma mark - Twitter Initialization
- (void)getCurrentTimeLine
{
    [LRTwitterAPI getMyTimelineWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (nil != error)
        {
            // TODO: handle errors
        }
        
        NSArray *newTweets = [NSJSONSerialization JSONObjectWithData:responseData
                               options:NSJSONReadingMutableLeaves
                               error:&error];
        self.tweets = newTweets;
        NSLog(@"ARRAY OF TWEETS %@", self.tweets);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dataSourceUpdated" object:self];
    }];
    
    // notification that we have loaded the current timeline
}

@end
