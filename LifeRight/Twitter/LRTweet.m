//
//  LRTweet.m
//  LifeRight
//
//  Created by Kevin Jenkins on 12/15/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRTweet.h"

NSString *const twitterUserKey = @"user";
NSString *const twitterDateKey = @"created_at";
NSString *const twitterNameKey = @"name";
NSString *const twitterMessageKey = @"text";
NSString *const twitterAvatarImageKey = @"profile_image_url";

NSString *const twitterPreSourceText = @"via";

static NSDateFormatter* dateFormatter;

@implementation LRTweet

+ (void)initialize
{
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"eee MMM dd HH:mm:ss ZZZZ yyyy";
}

- (id)initWithDictionary:(NSDictionary*)tweetDictionary
{
    self = [super init];

    if (nil != self) {
        [self setupWithDictionary:tweetDictionary];
    }
    return self;
}

- (void)setupWithDictionary:(NSDictionary*)tweetDictionary
{
    NSDictionary *userInfo = [tweetDictionary objectForKey:twitterUserKey];

    // load avatar image from URL
    NSURL *url = [NSURL URLWithString:[userInfo objectForKey:twitterAvatarImageKey]];
    NSData *data = [NSData dataWithContentsOfURL:url];

    self.author = [userInfo objectForKey:twitterNameKey];
    self.message = [tweetDictionary objectForKey:twitterMessageKey];
    self.date = [dateFormatter dateFromString:[tweetDictionary objectForKey:twitterDateKey]];
    self.avatarImage = [UIImage imageWithData:data];
}

- (BOOL)hasImage
{
    return NO;
}

- (NSString*)preSourceText
{
    return twitterPreSourceText;
}

- (UIImage*)sourceImage
{
    return [UIImage imageNamed:@"icon-twitter.png"];
}

+ (NSDateFormatter*)dateFormatter
{
    return dateFormatter;
}

@end
