//
//  LRTwitterAPI.m
//  LifeRight
//
//  Created by Kevin Jenkins on 11/3/12.
//  Copyright (c) 2012 somethingpointless. All rights reserved.
//

#import "LRTwitterAPI.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

NSString* const twitter_not_allowed = @"twitter_not_allowed";

@implementation LRTwitterAPI

+ (BOOL)isConnected
{
    return [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
}

+ (void)getMyTimelineWithHandler:(void(^)(NSData *responseData, NSHTTPURLResponse
                                          *urlResponse, NSError *error))block;
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [account
                                         accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:twitterAccountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             NSArray *arrayOfTwitterAccounts = [account
                                                accountsWithAccountType:twitterAccountType];
             if (0 == [arrayOfTwitterAccounts count])
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You must associate this device with a twitter account!" delegate:nil cancelButtonTitle:@"Aight." otherButtonTitles:nil];
                 [alertView show];
             }
             
             ACAccount *twitterAccount = [arrayOfTwitterAccounts lastObject];
             NSMutableDictionary *parameters =
             [[NSMutableDictionary alloc] init];
             [parameters setObject:@"20" forKey:@"count"];
             [parameters setObject:@"1" forKey:@"include_entities"];
             
             NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
             
             SLRequest *postRequest = [SLRequest
                                       requestForServiceType:SLServiceTypeTwitter
                                       requestMethod:SLRequestMethodGET
                                       URL:requestURL parameters:parameters];
             
             postRequest.account = twitterAccount;
             
             [postRequest performRequestWithHandler:block];
             /*
             [postRequest performRequestWithHandler:
              ^(NSData *responseData, NSHTTPURLResponse
                *urlResponse, NSError *error)
              {
                  NSArray *dataSource = [NSJSONSerialization
                                         JSONObjectWithData:responseData
                                         options:NSJSONReadingMutableLeaves
                                         error:&error];
                  
                  NSLog(@"ARRAY OF TWEETS %@", dataSource);
              }];
              */
         }
         else
         {
             [[NSNotificationCenter defaultCenter] postNotificationName:twitter_not_allowed object:self];
         }
         
     }];
}


@end
