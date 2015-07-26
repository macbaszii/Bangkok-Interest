//
//  MLPlace.h
//  MLBangkokInterest
//
//  Created by Kiattisak Anoochitarom on 7/26/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLPlace : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *rating;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *website;

- (instancetype)initWithFoursquareResponse:(NSDictionary *)response;
+ (instancetype)placeWithFoursquareResponse:(NSDictionary *)response;

@end
