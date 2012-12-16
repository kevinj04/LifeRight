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
#import "LRTweetContent.h"
#import "LRAdvertisementContent.h"

@implementation LRCollectionViewDataSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.tweets = [[NSMutableArray alloc] initWithCapacity:100];
        self.ads = [[NSMutableArray alloc] initWithCapacity:20];
        self.contentStream = [[NSMutableArray alloc] initWithCapacity:120];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource Delegate Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnyCell" forIndexPath:indexPath];

    LRCellContent *contentObject = [self.contentStream objectAtIndex:indexPath.row];

    [cell setupWithContent:contentObject];

    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contentStream.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


#pragma mark - Content Initialization
- (void)gatherContentStream
{
    [self getCurrentTimeLine];
    [self getAds];
}
- (void)updateContentStreamWithContent:(NSArray*)contentArray
{
    [self.contentStream addObjectsFromArray:contentArray];
    self.contentStream = [self.contentStream sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if (arc4random_uniform(2) == 0) return NSOrderedAscending;
        else return NSOrderedDescending;
    }].mutableCopy;
}
- (void)getCurrentTimeLine
{
    [LRTwitterAPI getMyTimelineWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if (nil != error)
        {
            // TODO: handle errors
        }
        
        NSArray *newTweetDictionaries = [NSJSONSerialization JSONObjectWithData:responseData
                               options:NSJSONReadingMutableLeaves
                               error:&error];


        for (NSDictionary *tweetDictionary in newTweetDictionaries)
        {
            [self.tweets addObject:[[LRTweetContent alloc] initWithDictionary:tweetDictionary]];
        }

        NSLog(@"ARRAY OF TWEETS %@", self.tweets);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dataSourceUpdated" object:self.tweets];
    }];
    
    // notification that we have loaded the current timeline
}

- (void)getAds
{
    // in the future get a list of *NEW* undisplayed ads
    for (int i=0; i<7; i++) {
        LRAdvertisementContent *adObject = [[LRAdvertisementContent alloc] init];
        [self.ads addObject:adObject];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataSourceUpdated" object:self.ads];
}

#pragma mark - Size Prediction
- (CGSize)sizeForCellAtIndexPath:(NSIndexPath*)indexPath
{
    LRCellContent *contentObject = [self.contentStream objectAtIndex:indexPath.row];
    return [LRCollectionViewCell predictSizeForContent:contentObject];
}

@end
