//
//  MLPlace.m
//  MLBangkokInterest
//
//  Created by Kiattisak Anoochitarom on 7/26/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

#import "MLPlace.h"

@implementation MLPlace

- (instancetype)initWithFoursquareResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        // Parsing Code
        NSDictionary *place = response[@"venue"];
        
        self.title = place[@"name"];
        self.rating = place[@"rating"];
        
        NSDictionary *placePhoto = place[@"photos"];
        NSArray *photoGroups = placePhoto[@"groups"];
        NSDictionary *placePhotoGroups = photoGroups.firstObject;
        NSArray *photos = placePhotoGroups[@"items"];
        NSDictionary *photo = photos.firstObject;
        // prefix + original + suffix
        
        NSString *photoURLString = [NSString stringWithFormat:@"%@original%@", photo[@"prefix"],photo[@"suffix"]];
        
        self.imageURL = [NSURL URLWithString:photoURLString];
        
        NSDictionary *location = place[@"location"];
        self.address = [location[@"formattedAddress"] componentsJoinedByString:@" "];
        
        self.telephone = place[@"contact"][@"phone"];
        self.website = place[@"url"];
    }
    
    return self;
}

+ (instancetype)placeWithFoursquareResponse:(NSDictionary *)response {
    return [[MLPlace alloc] initWithFoursquareResponse:response];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Title: %@\nRating: %.1f\nImageURL: %@", self.title, [self.rating doubleValue], self.imageURL];
}

@end
