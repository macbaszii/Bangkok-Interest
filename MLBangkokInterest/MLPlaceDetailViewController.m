//
//  MLPlaceDetail.m
//  MLBangkokInterest
//
//  Created by Kiattisak Anoochitarom on 7/26/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "MLPlaceDetailViewController.h"
#import "MLPlace.h"

@interface MLPlaceDetailViewController()

@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *webButton;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation MLPlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI {
    [self.placeImageView sd_setImageWithURL:self.place.imageURL
                           placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
    self.titleLabel.text = self.place.title;
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", [self.place.rating doubleValue]];
    self.addressLabel.text = self.place.address;
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.place.telephone]];
    NSURL *webURL = [NSURL URLWithString:self.place.website];
    
    if (![[UIApplication sharedApplication] canOpenURL:webURL]) {
        self.webButton.enabled = NO;
    }
    
    if (![[UIApplication sharedApplication] canOpenURL:phoneURL]) {
        self.phoneButton.enabled = NO;
    }
}

#pragma mark - Action

- (IBAction)call:(id)sender {
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.place.telephone]];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (IBAction)openWeb:(id)sender {
    NSURL *webURL = [NSURL URLWithString:self.place.website];
    [[UIApplication sharedApplication] openURL:webURL];

}

@end
