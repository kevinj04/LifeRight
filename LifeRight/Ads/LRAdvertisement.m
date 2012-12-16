//
//  LRAdvertisement.m
//  LifeRight
//
//  Created by Kevin Jenkins on 12/15/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRAdvertisement.h"

@implementation LRAdvertisement

- (id)init
{
    self = [super init];
    if (self)
    {
        self.author = @"A Random Business";
        self.date = [NSDate dateWithTimeIntervalSinceNow:2000000];

        // TODO: get asynch and update when done
        //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://placekitten.com/250/250"]];

        self.image = [UIImage imageNamed:@"ad-california-tort.png"];
    }
    return self;
}

- (BOOL)hasImage
{
    return self.image != nil;
}

@end
