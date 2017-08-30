//
//  MovieDetailsViewController.h
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieResponse;

@interface MovieDetailsViewController : UIViewController

//Data pass in by segue
@property (nonatomic, strong) MovieResponse    *movieInfo;

@end
