//
//  ViewController.m
//  MLBangkokInterest
//
//  Created by Kiattisak Anoochitarom on 7/25/2558 BE.
//  Copyright (c) 2558 Kiattisak Anoochitarom. All rights reserved.
//

#import "BangkokPlacesViewController.h"
#import "MLPlace.h"
#import "MLFoursquareAPIManager.h"
#import "MLPlaceCell.h"
#import "MLPlaceDetailViewController.h"

static NSString * const MLPlaceCellIdentifier = @"MLPlaceCell";
static NSString * const MLPlaceDetailSegueIdentifier = @"MLPlaceDetailSegue";

@interface BangkokPlacesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *places;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BangkokPlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 120.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [[MLFoursquareAPIManager manager] placesInBangkokWithCompletionBlock:^(NSArray *places, NSError *error) {
        if (error) {
            UIAlertController *alert = [[MLFoursquareAPIManager manager] alertWithError:error];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            self.places = places;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:MLPlaceDetailSegueIdentifier]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
        MLPlaceDetailViewController *detailVC = segue.destinationViewController;
        detailVC.place = self.places[selectedIndexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:MLPlaceCellIdentifier
                                                        forIndexPath:indexPath];
    MLPlace *currentPlace = self.places[indexPath.row];
    [cell configureCellWithPlace:currentPlace];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
