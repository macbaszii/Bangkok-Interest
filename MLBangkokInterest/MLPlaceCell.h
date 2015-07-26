//
//  MLPlaceCell.h
//  MLBangkokInterest
//
//  Created by Kiattisak Anoochitarom on 7/26/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLPlace;

@interface MLPlaceCell : UITableViewCell

- (void)configureCellWithPlace:(MLPlace *)place;

@end
