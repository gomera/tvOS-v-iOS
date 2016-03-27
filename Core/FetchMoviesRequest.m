//
//  FetchMoviesRequest.m
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/20/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import "FetchMoviesRequest.h"
#import "Constants.h"

#define SERVER_URL_FETCH_MOVIES                 [NSString stringWithFormat:@"%@/movies.js", BASE_URL]

#define HTTP_ACCEPT_HEADER_FIELD_KEY            @"Accept"
#define HTTP_ACCEPT_HEADER_FIELD_VALUE          @"application/json"
#define HTTP_CONTENT_TYPE_HEADER_FIELD_KEY      @"Content-Type"
#define HTTP_CONTENT_TYPE_HEADER_FIELD_VALUE    @"application/json"

@implementation FetchMoviesRequest

- (NSURLRequest *) request {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SERVER_URL_FETCH_MOVIES]];
    [request setValue:HTTP_ACCEPT_HEADER_FIELD_VALUE forHTTPHeaderField:HTTP_ACCEPT_HEADER_FIELD_KEY];
    [request setValue:HTTP_CONTENT_TYPE_HEADER_FIELD_VALUE forHTTPHeaderField:HTTP_CONTENT_TYPE_HEADER_FIELD_KEY];
    return request;
}

- (void) executeWithCompletion:(void(^)(NSArray<Movie*> *movies, NSError *error))completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[self request] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSMutableArray<Movie*> *movies = [NSMutableArray array];
        if (error == nil) {
            NSError *jsonParseError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParseError];
            for (NSDictionary *jsonMovie in json[@"movies"]) {
                [movies addObject:[[Movie alloc] initWithDictionary:jsonMovie]];
            }
        }
        completion(movies, error);
    }];
    [dataTask resume];
}

@end
