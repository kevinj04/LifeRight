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
#import "LRTweet.h"
#import "LRAdvertisement.h"

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

    [self updateContentStream];
}
- (void)updateContentStream
{
    [self.contentStream addObjectsFromArray:self.ads];
    [self.contentStream addObjectsFromArray:self.tweets];
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
            [self.tweets addObject:[[LRTweet alloc] initWithDictionary:tweetDictionary]];
        }

        NSLog(@"ARRAY OF TWEETS %@", self.tweets);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dataSourceUpdated" object:self];
    }];
    
    // notification that we have loaded the current timeline
}

- (void)getAds
{
    for (int i=0; i<3; i++) {
        LRAdvertisement *adObject = [[LRAdvertisement alloc] init];
        [self.ads addObject:adObject];
    }
}

#pragma mark - Size Prediction
- (CGSize)sizeForCellAtIndexPath:(NSIndexPath*)indexPath
{
    LRCellContent *contentObject = [self.contentStream objectAtIndex:indexPath.row];
    return [LRCollectionViewCell predictSizeForContent:contentObject];
}

@end
