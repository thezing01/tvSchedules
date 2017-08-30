//
//  MovieRequest.m
//  tvSchedules
//
//  Created by Tik on 30/8/17.
//  Copyright © 2017 tipayanond. All rights reserved.
//

#import "MovieRequest.h"
#import <RestKit/RestKit.h>
#import "MovieResponse.h"

@implementation MovieRequest

-(void)makeRequestWithUrl:(NSURL *)url withCallback:(MovieRequestCallback)callback {
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSArray *responseDescriptors = [self responseDescriptorsWithPathPattern:url.path];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:urlRequest
                                                                        responseDescriptors:responseDescriptors];
    
    [operation
     setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         
         //debugging purpose
         DDLogDebug(@"*** Movie Request got array ***");
         for(MovieResponse *movie in mappingResult.array) {
             DDLogDebug(@"%@", movie.description);
         }
         callback(mappingResult.array, nil);
     }
     failure:^(RKObjectRequestOperation *operation, NSError *error) {
         DDLogDebug(@"Movie Request error: %@", error.localizedDescription);
         callback(@[],error);
     }];
    
    // make the request
    [operation start];
}

-(NSArray *) responseDescriptorsWithPathPattern:(NSString *)path {
    // Restkit object mappings
    RKObjectMapping *movieResponseMapping = [RKObjectMapping mappingForClass:[MovieResponse class]];
    [movieResponseMapping addAttributeMappingsFromDictionary:@{ @"name" : @"name",
                                                                @"start_time": @"startTime",
                                                                @"end_time": @"endTime",
                                                                @"channel": @"channel",
                                                                @"rating": @"rating"}];
    
    NSIndexSet *returnCode = [NSIndexSet indexSetWithIndex:200];
    RKResponseDescriptor *respDesc = [RKResponseDescriptor responseDescriptorWithMapping:movieResponseMapping
                                                                                  method:RKRequestMethodGET
                                                                             pathPattern:path
                                                                                 keyPath:@"results"
                                                                             statusCodes:returnCode];
    
    return @[respDesc];
}

@end
