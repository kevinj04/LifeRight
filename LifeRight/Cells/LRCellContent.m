//
//  LRCellContent.m
//  LifeRight
//
//  Created by Kevin Jenkins on 12/15/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRCellContent.h"

@implementation LRCellContent

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self)
    {
        [self setupWithDictionary:dictionary];
    }
    return self;
}
- (void)setupWithDictionary:(NSDictionary*)dictionary
{

}
- (BOOL)hasImage
{
    return NO;
}
- (NSString*)preSourceText
{
    return @"NO SET VALUE";
}
- (UIImage*)sourceImage
{
    return nil;
}
+ (NSDateFormatter*)dateFormatter
{
    return nil;
}

@end
