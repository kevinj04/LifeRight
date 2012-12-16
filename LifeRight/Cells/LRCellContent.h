//
//  LRCellContent.h
//  LifeRight
//
//  Created by Kevin Jenkins on 12/15/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRCellContent : NSObject

@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIImage *sourceImage;
@property (strong, nonatomic) NSString *sourceText;

#pragma mark - Initialization
- (id)initWithDictionary:(NSDictionary*)dictionary;

#pragma mark - Date Formatting
+ (NSDateFormatter*)dateFormatter;

#pragma mark - Content Information
- (BOOL)hasMessage;
- (BOOL)hasImage;

@end
