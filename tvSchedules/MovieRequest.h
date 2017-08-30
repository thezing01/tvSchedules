//
//  MovieRequest.h
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieResponse;

typedef void (^MovieRequestCallback) ( NSArray<MovieResponse *> * _Nonnull movies, NSError * _Nullable error);

@interface MovieRequest : NSObject

-(void)makeRequestWithUrl:(NSURL *_Nonnull)url withCallback:(MovieRequestCallback _Nonnull )callback;

@end
