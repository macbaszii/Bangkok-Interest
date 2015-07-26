//
//  MLFoursquareAPIManager.h
//  MLBangkokInterest
//
//  Created by Kiattisak Anoochitarom on 7/26/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^MLPlacesCompletionBlock)(NSArray *places, NSError *error);

@interface MLFoursquareAPIManager : AFHTTPSessionManager

+ (instancetype)manager;

- (void)placesInBangkokWithCompletionBlock:(MLPlacesCompletionBlock)block;
- (UIAlertController *)alertWithError:(NSError *)error;

@end
