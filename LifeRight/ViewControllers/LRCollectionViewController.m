//
//  LRCollectionViewController.m
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRCollectionViewController.h"
#import "LRCollectionViewCell.h"
#import "LRTwitterAPI.h"

@interface LRCollectionViewController ()

@end

@implementation LRCollectionViewController

#pragma mark - Initialization and Setup
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTwitterNotAllowedNotification:) name:twitter_not_allowed object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDataSourceUpdated:) name:@"dataSourceUpdated" object:nil];
}

#pragma mark - Life Cycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataSource = [[LRCollectionViewDataSource alloc] init];

    [self registerNotifications];

    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
    //[self.collectionView registerClass:[LRCollectionViewCell class] forCellWithReuseIdentifier:@"AnyCell"];
    UINib *cellNib = [UINib nibWithNibName:@"LRCollectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"AnyCell"];

    [self.dataSource gatherContentStream];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark – UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource sizeForCellAtIndexPath:indexPath];
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark - UICollectionViewDataSource Delegate Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource collectionView:collectionView numberOfItemsInSection:section];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataSource numberOfSectionsInCollectionView:collectionView];
}


#pragma mark - Data Source Update Handlers
- (void)handleDataSourceUpdated:(NSNotification*)notification
{
    NSArray *contentArray = (NSArray*)[notification object];
    [self.dataSource updateContentStreamWithContent:contentArray];
    NSLog(@"New content stream: %@",  self.dataSource.contentStream);
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

#pragma mark - Notification Handlers
- (void)handleTwitterNotAllowedNotification:(NSNotification*)notification
{
    // must run this on the main thread
    [self performSelectorOnMainThread:@selector(postFailedToAccessTwitterAlert:) withObject:notification waitUntilDone:NO];

}
- (void)postFailedToAccessTwitterAlert:(NSNotification*)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You must allow this app to access twitter!" delegate:nil cancelButtonTitle:@"Aight." otherButtonTitles:nil];
    [alertView show];
}

@end
