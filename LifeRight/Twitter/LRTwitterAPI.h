//
//  LRTwitterAPI.h
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRTwitterAPI : NSObject

+ (BOOL)isConnected;

+ (void)getMyTimelineWithHandler:(void(^)(NSData *responseData, NSHTTPURLResponse
                                          *urlResponse, NSError *error))block;

@end
