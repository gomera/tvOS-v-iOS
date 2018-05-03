//
//  BaseVideosViewController.m
//  NSConfAr2016 tvOS Demo App
//
//  Created by Diego Sebastian Mera on 3/15/16.
//  Copyright © 2016 Diego Sebastian Mera. All rights reserved.
//

#import "BaseVideosViewController.h"
#import "FetchMoviesRequest.h"
#import "YouTubeScrapper.h"
@import AVKit;
@import AVFoundation;

static const NSString *ItemStatusContext;

@interface BaseVideosViewController ()

@property (nonatomic, strong) NSArray<Movie*> *movies;
@property (nonatomic, strong) FetchMoviesRequest *fetchRequest;
@property (nonatomic, strong) UIAlertController *loadingAlert;

@property(nonatomic, strong) NSString *videoIdentifier;
@property(nonatomic, strong) AVPlayer *player;

@end

@implementation BaseVideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fetchRequest = [FetchMoviesRequest new];
    [self.fetchRequest executeWithCompletion:^(NSArray<Movie *> *movies, NSError *error) {
        self.movies = movies;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        })
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoItemListCell" forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie *movie = self.movies[indexPath.row];
    cell.textLabel.text = movie.title;
    cell.detailTextLabel.text = movie.summary;
    //TODO: This is blocking the UI !
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:movie.thumbnail]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self playMovieAtIndexPath:indexPath];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &ItemStatusContext) {
        
        if (self.player.status == AVPlayerStatusReadyToPlay) {
            [self.player removeObserver:self forKeyPath:@"status"];
            [self.player play];
        } else if (self.player.status == AVPlayerStatusFailed){
            
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) playMovieAtIndexPath:(NSIndexPath *) indexPath {
    Movie *movie = self.movies[indexPath.row];
    [YouTubeScrapper fetchYouTubeSteramURLFromLink:movie.videoURL withCompletion:^(NSURL *url) {
        if (url != nil) {
            AVPlayerViewController *playerViewController = [AVPlayerViewController new];
            
            self.player = [AVPlayer playerWithURL:url];
            [self.player addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
            playerViewController.player = self.player;
            
            [self presentViewController:playerViewController animated:YES completion:nil];
        }
    }];
}

@end
