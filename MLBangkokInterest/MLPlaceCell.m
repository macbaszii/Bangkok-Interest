//
//  MLPlaceCell.m
//  MLBangkokInterest
//
//  Created by Kiattisak Anoochitarom on 7/26/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "MLPlaceCell.h"
#import "MLPlace.h"

@interface MLPlaceCell()

@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end

@implementation MLPlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.placeImageView.layer.masksToBounds = YES;
    self.placeImageView.layer.cornerRadius = CGRectGetWidth(self.placeImageView.bounds) / 2;
}

- (void)configureCellWithPlace:(MLPlace *)place {
    self.placeTitleLabel.text = place.title;
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", [place.rating doubleValue]];
    
    [self.placeImageView sd_setImageWithURL:place.imageURL
                           placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    
//    self.placeImageView.image = [UIImage imageNamed:@"image-placeholder"];
//    // Download image in background and set image in main queue manually
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSData *imageData = [NSData dataWithContentsOfURL:place.imageURL];
//        UIImage *image = [UIImage imageWithData:imageData];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.placeImageView.image = image;
//        });
//    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.placeTitleLabel setNeedsUpdateConstraints];
}

@end
