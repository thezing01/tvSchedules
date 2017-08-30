//
//  MovieListViewController.m
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieRequest.h"
#import "MovieResponse.h"
#import "AppSettings.h"
#import "UIImage+tv.h"
#import "MovieDetailsViewController.h"
#import "SpinnerTableViewCell.h"

const int       MAX_MOVIES_ROWCOUNT     =   50;
const float     HEADER_HEIGHT           =   40.0f;
const NSString *CELL_IDENTIFIER         =   @"ShowDetailCell";
const NSString *SPINNER_CELL_IDENTIFIER =   @"SpinnerCell";

@interface MovieListViewController ()

@end

@implementation MovieListViewController {
    NSArray<MovieResponse *>        *_movieArray;
    BOOL                             _isAddSpinnerCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _movieArray = @[];
    [self requestSchedules];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.alpha = 1.0;
    navBar.barTintColor = [UIColor colorWithRed:0.22f green:0.33f blue:0.53f alpha:1.0f];
    navBar.translucent = NO;
    navBar.titleTextAttributes =
        @{ NSForegroundColorAttributeName : [UIColor whiteColor],
           NSFontAttributeName            : [UIFont boldSystemFontOfSize:20] };
}

#pragma mark - Table Data

- (void)requestSchedules {
    
    // URL rosters from https://www.whatsbeef.net/wabz/guide.php?start=1 to
    // https://www.whatsbeef.net/wabz/guide.php?start=10 until the table is filled with 50 rows.
    // After 50 rows, the table is cleared and re-populated with the next URL roster.
    
    _isAddSpinnerCell = NO;
    MovieRequest *request = [[MovieRequest alloc] init];
    NSString *urlStr = [[AppSettings sharedInstance] showURL];
    NSURL *url = [NSURL URLWithString:urlStr];
    [request makeRequestWithUrl:url withCallback:^(NSArray<MovieResponse *> * _Nonnull movies, NSError * _Nullable error) {
        if(error) {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Error Occurred"
                                         message:error.localizedDescription
                                         preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
                [self failedRequestingSchedules];
            }];
            
        }else if(movies.count > 0) {
            [self succeedRequestingSchedules:movies];
            
        }
    }];
}

-(void)succeedRequestingSchedules:(NSArray<MovieResponse *> *)movies {
    if(_movieArray.count >= MAX_MOVIES_ROWCOUNT) {
        _movieArray = @[];
    }
    NSMutableArray *mutableMovies = [_movieArray mutableCopy];
    _movieArray = [mutableMovies arrayByAddingObjectsFromArray:movies];
    [self.tableView reloadData];
}

-(void)failedRequestingSchedules {
    _isAddSpinnerCell = NO;
    if(_movieArray.count == 0) {
        [self requestSchedules];
    }else{
        [self.tableView reloadData];
    }
}

#pragma mark - Table Management

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MovieDetails" sender:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

/**
 * Provide Account cells
 */
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL isLastRow = NO;
    NSString *cellIdentifier = (NSString *)CELL_IDENTIFIER;
    NSInteger numRow = [self tableView:tableView numberOfRowsInSection:0];
    if(indexPath.row == numRow-1) {
        // last row is the loading spinner
        cellIdentifier = (NSString *)SPINNER_CELL_IDENTIFIER;
        isLastRow = YES;
    }
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell) {
        if(isLastRow) {
            SpinnerTableViewCell *spinnerCell = (SpinnerTableViewCell *)cell;
            if(![spinnerCell.spinnerView isAnimating]) {
                [spinnerCell.spinnerView startAnimating];
            }
        }else{
            MovieResponse *movie = _movieArray[indexPath.row];
            cell.imageView.image = [UIImage tvChannelByName:movie.channel];
            cell.textLabel.text = movie.name;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", movie.startTime, movie.endTime];
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage tvRatingByCode:movie.rating]];
            int width = 45;
            if([movie.rating isEqualToString:@""] || [movie.rating isEqualToString:@"NR"]) {
                // No Rating image is longer than other ratings
                width = 75;
            }
            [cell.accessoryView setFrame:CGRectMake(0, 0, width, 25)];
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount = _movieArray.count;
    if(_isAddSpinnerCell) {
        rowCount++;  //add the spinner to the last row
    }
    return rowCount;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_HEIGHT;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGRect rect = CGRectMake(0, 0, tableView.bounds.size.width, HEADER_HEIGHT);
    UIView *headerView = [[UIView alloc] initWithFrame:rect];
    [headerView setBackgroundColor:[UIColor lightGrayColor]];
    
    CGRect titleRect = rect;
    titleRect.origin.x = 15;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleRect];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    [headerView addSubview:titleLabel];
    
    return headerView;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"TONIGHT";
}

#pragma mark - Scrolling

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger lastRowIndex = [self tableView:tableView numberOfRowsInSection:0]-1;
    if(indexPath.row == lastRowIndex) {
        // Showing the last row
        _isAddSpinnerCell = YES;
        [self requestSchedules];
    }
}

#pragma mark - Segue related

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"MovieDetails"]) {
        MovieDetailsViewController *movieDetailsVC = (MovieDetailsViewController *)segue.destinationViewController;
        
        movieDetailsVC.movieInfo = _movieArray[self.tableView.indexPathForSelectedRow.row];
    }
}

@end
