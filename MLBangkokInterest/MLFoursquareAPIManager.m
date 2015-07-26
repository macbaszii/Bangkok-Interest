//
//  MLFoursquareAPIManager.m
//  MLBangkokInterest
//
//  Created by Kiattisak Anoochitarom on 7/26/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

#import "MLFoursquareAPIManager.h"
#import "MLPlace.h"

static NSString * const FSAPIBaseURL = @"https://api.foursquare.com/v2";
static NSString * const FSAPIKey = @"IT45NJR3O05ES2IVDAGMQLLOWL0MYJCPJGCB4TBFJL2UMQYP";
static NSString * const FSAPISecret = @"CYQC40KH4LDJE304PPJXNBXFASZFIEZBL0D0HZKSXOE2QAVO";

@implementation MLFoursquareAPIManager

+ (instancetype)manager {
    static MLFoursquareAPIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MLFoursquareAPIManager alloc] initWithBaseURL:[NSURL URLWithString:FSAPIBaseURL]];
    });
    
    return manager;
}

- (void)placesInBangkokWithCompletionBlock:(MLPlacesCompletionBlock)block {
    NSParameterAssert(block != nil);
    
    NSDictionary *params = @{ @"near": @"Bangkok" };
    params = [self addDefaultParamaters:params];
    
    NSString *explorePath = [FSAPIBaseURL stringByAppendingPathComponent:@"venues/explore"];
    
    [self GET:explorePath
     parameters:params
        success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *foursquareResponse = responseObject[@"response"];
            NSArray *groups = foursquareResponse[@"groups"];
            NSDictionary *recommendedGroup = groups.firstObject;
            NSArray *items = recommendedGroup[@"items"];
            
            NSMutableArray *tmpPlaces = [@[] mutableCopy];
            for (NSDictionary *item in items) {
                MLPlace *place = [MLPlace placeWithFoursquareResponse:item];
                NSLog(@"%@", place);
                [tmpPlaces addObject:place];
            }
            
            block(tmpPlaces, nil);
        }
        failure:^(NSURLSessionDataTask *task, NSError *error) {
            block(nil, error);
        }];
}

- (NSDictionary *)addDefaultParamaters:(NSDictionary *)params {
    NSMutableDictionary *mutableParams = [params mutableCopy];
    mutableParams[@"client_id"] = FSAPIKey;
    mutableParams[@"client_secret"] = FSAPISecret;
    mutableParams[@"venuePhotos"] = @(1);
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyymmdd";
    
    mutableParams[@"v"] = [dateFormatter stringFromDate:today];
    
    return mutableParams;
}

- (UIAlertController *)alertWithError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Try again"
                                              style:UIAlertActionStyleDefault handler:nil]];
    
    return alert;
}

@end
