//
//  MovieResponse.m
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import "MovieResponse.h"

@implementation MovieResponse

- (NSString *)description {
    return [NSString stringWithFormat:@"name: %@, time: %@ - %@, channel:%@, rating:%@", self.name,
            self.startTime, self.endTime, self.channel, self.rating];
}

@end
