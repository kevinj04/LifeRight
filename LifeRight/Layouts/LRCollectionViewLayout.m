//
//  LRCollectionViewLayout.m
//  LifeRight
//
//  Created by Kevin Jenkins on 12/16/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRCollectionViewLayout.h"
#import "LRCollectionViewController.h"
#import "LRCollectionViewDataSource.h"
#import "LRCollectionViewCell.h"
#import "LRCellContent.h"

@implementation LRCollectionViewLayout

#pragma mark - Initialization
- (id)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.numberOfColumns = 3;
    self.columnWidth = 320.0;
    self.columnSpacing = 10.0;
    self.verticalCellSpacing = 10.0;

    self.layoutInformation = [NSDictionary dictionary];

    [self resetColumnData];
}

- (void)resetColumnData
{
    self.columnBottom = [NSMutableArray arrayWithCapacity:self.numberOfColumns];
    for (int column = 0; column<self.numberOfColumns; column++)
    {
        [self.columnBottom addObject:@0];
    }
}

#pragma mark - Layout Delegate Methods

- (void)prepareLayout
{
    [self resetColumnData];

    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];

    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];

    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];

        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];

            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForContentCellAtIndexPath:indexPath];

            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }

    newLayoutInfo[@"contentCell"] = cellLayoutInfo;

    self.layoutInformation = newLayoutInfo;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInformation.count];

    [self.layoutInformation enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];

    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInformation[@"contentCell"][indexPath];
}

- (CGSize)collectionViewContentSize
{
    // calculate the width
    CGFloat width = self.columnSpacing + (self.columnSpacing + self.columnWidth) * self.numberOfColumns;

    // determine which column is the is the lowest
    int targetColumn = [self lowestColumn];

    CGFloat height = [[self.columnBottom objectAtIndex:targetColumn] floatValue];

    return CGSizeMake(width, height);
}

#pragma mark - Helper Methods
- (CGRect)frameForContentCellAtIndexPath:(NSIndexPath *)indexPath
{
    LRCollectionViewController *viewController = (LRCollectionViewController*)self.collectionView.dataSource;
    LRCollectionViewDataSource *lrDataSource = viewController.dataSource;
    LRCellContent *content = [lrDataSource.contentStream objectAtIndex:indexPath.row];

    // get the size of this cell
    CGSize cellSize = [LRCollectionViewCell predictSizeForContent:content];

    // determine which column should have this cell
    int targetColumn = [self highestColumn];

    // get the next origin for this column
    CGPoint frameOrigin = [self originForColumn:targetColumn];

    // construct the frame
    CGRect newCellFrame = CGRectMake(frameOrigin.x, frameOrigin.y, cellSize.width, cellSize.height);

    // update the column bottom value
    [self.columnBottom replaceObjectAtIndex:targetColumn withObject:[NSNumber numberWithFloat:frameOrigin.y+cellSize.height]];

    return newCellFrame;
}

// returns the index of the column with the most space beneath it
- (NSUInteger)highestColumn
{
    __block NSNumber *highest = [NSNumber numberWithFloat:MAXFLOAT];
    __block NSUInteger targetIndex = -1;
    [self.columnBottom enumerateObjectsUsingBlock:^(id columnHeight, NSUInteger idx, BOOL *stop) {
        NSLog(@"Comparing %@ to %@", columnHeight, highest);
        if ([columnHeight floatValue] < [highest floatValue])
        {
            highest = columnHeight;
            targetIndex = idx;
        }
    }];

    NSAssert(targetIndex != -1, @"FAILED TO CALCULATE HIGHEST COLUMN");

    return targetIndex;
}

- (NSUInteger)lowestColumn
{
    // the lowest column is the one which has the least room beneath it
    __block NSNumber *lowest = @0;
    __block NSUInteger targetIndex = -1;
    [self.columnBottom enumerateObjectsUsingBlock:^(id columnHeight, NSUInteger idx, BOOL *stop) {
        if ([columnHeight floatValue] > [lowest floatValue])
        {
            lowest = columnHeight;
            targetIndex = idx;
        }
    }];

    NSAssert(targetIndex != -1, @"FAILED TO CALCULATE LOWEST COLUMN");

    return targetIndex;
}

- (CGFloat)xCoordinateForColumn:(int)columnIndex
{
    return self.columnSpacing + (self.columnWidth+self.columnSpacing) * columnIndex;
}

- (CGPoint)originForColumn:(int)columnIndex
{
    return CGPointMake([self xCoordinateForColumn:columnIndex], [[self.columnBottom objectAtIndex:columnIndex] floatValue] + self.verticalCellSpacing);
}

@end
