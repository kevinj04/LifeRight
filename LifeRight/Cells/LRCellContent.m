//
//  LRCellContent.m
//  LifeRight
//
//  Created by Kevin Jenkins on 12/15/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRCellContent.h"

@implementation LRCellContent

#pragma mark - Initialization
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
    self.author = @"";
    self.message = @"";
    self.avatarImage = nil; // should get a placeholder avatar?
    self.image = nil; // should get a placeholder image?
    self.date = nil;
    self.sourceText = @"";
}

#pragma mark - Date Formatting
+ (NSDateFormatter*)dateFormatter
{
    return nil;
}

#pragma mark - Content Information
- (BOOL)hasMessage
{
    return (0 < self.message.length);
}
- (BOOL)hasImage
{
    return (self.image != nil);
}


@end
