//
//  MovieResponse.h
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieResponse : NSObject

@property (nonatomic, copy) NSString  *name;
@property (nonatomic, copy) NSString  *startTime;
@property (nonatomic, copy) NSString  *endTime;
@property (nonatomic, copy) NSString  *channel;
@property (nonatomic, copy) NSString  *rating;

@end
