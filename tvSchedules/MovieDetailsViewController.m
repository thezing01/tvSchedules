//
//  MovieDetailsViewController.m
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "MovieResponse.h"
#import "UIImage+tv.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UITextView *movieTextView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.movieInfo.name;
    self.movieTitleLabel.text = self.movieInfo.name;
    self.movieTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", self.movieInfo.startTime, self.movieInfo.endTime];
    self.ratingImageView.image = [UIImage tvRatingByCode:self.movieInfo.rating];
    self.movieTextView.text = @"Put a review about this movie here";
    
    [self.view bringSubviewToFront:self.movieTitleLabel];
    [self.view bringSubviewToFront:self.movieTimeLabel];
    [self.view bringSubviewToFront:self.ratingImageView];
}




@end
