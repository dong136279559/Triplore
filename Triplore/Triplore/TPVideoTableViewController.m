//
//  TPVideoTableViewController.m
//  Triplore
//
//  Created by Sorumi on 17/6/2.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import "TPVideoTableViewController.h"
#import "TPVideoSeriesTableViewCell.h"
#import "TPPlayViewController.h"
#import "TPVideoModel.h"
#import "TPNetworkHelper.h"
#import "Utilities.h"
#import "TPVideoManager.h"
#import "TPVideo.h"
#import "SVProgressHUD.h"
#import "MJRefreshAutoGifFooter.h"

@interface TPVideoTableViewController () 

@property (nonatomic) NSUInteger page;
@property (nonatomic, strong) NSArray* keywordsArray;
@property (nonatomic, strong) NSArray* videos;
@property (nonatomic, strong) MJRefreshAutoGifFooter *footer;

@end

@implementation TPVideoTableViewController

static NSString *singleCellIdentifier = @"TPVideoSingleTableViewCell";
static NSString *seriesCellIdentifier = @"TPVideoSeriesTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [Utilities getBackgroundColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    // cell
    UINib *nib1 = [UINib nibWithNibName:@"TPVideoSingleTableViewCell" bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:singleCellIdentifier];

    UINib *nib2 = [UINib nibWithNibName:@"TPVideoSeriesTableViewCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:seriesCellIdentifier];

    //
    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationItem.title = self.keywords;
    self.page = 1;
    
    if (self.site == NULL) {
        self.keywordsArray = [[self.keywords componentsSeparatedByString: @" "] arrayByAddingObject:@"旅游"];
    } else {
        self.keywordsArray = [[self.keywords componentsSeparatedByString: @" "] arrayByAddingObject:self.site];
    }
    
    // footer
    self.footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    //    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = self.footer;
    [self.footer setHidden:YES];
    
    // request
    [SVProgressHUD show];
    [self request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

#pragma mark - Request

- (void)request {

    [TPNetworkHelper fetchVideosByKeywords:self.keywordsArray withSize:10 inPage:self.page withBlock:^(NSArray<TPVideoModel *> *videos, NSError *error) {
        self.videos = videos;
        self.page ++;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        [self.footer setHidden:NO];
    }];
}

- (void)requestMore {
    NSLog(@"more!!!");
    [TPNetworkHelper fetchVideosByKeywords:self.keywordsArray withSize:10 inPage:self.page withBlock:^(NSArray<TPVideoModel *> *videos, NSError *error) {
        self.videos = [self.videos arrayByAddingObjectsFromArray:videos];
        self.page ++;
        NSLog(@"%d", videos.count);
        [self.tableView reloadData];
        [self.footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.videos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TPVideoModel *video = self.videos[indexPath.section];
    
//    if (video.videoType == TPVideoAlbum) {
//        TPVideoSeriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:seriesCellIdentifier forIndexPath:indexPath];
//        cell.video = video;
//        
//        [TPNetworkHelper fetchVideosInAlbum:@"" andAlbumID:[NSString stringWithFormat:@"%d", video.videoid] withBlock:^(NSArray<TPVideoModel *> * _Nonnull videos, NSError * _Nullable error) {
//            
//            NSLog(@"%@ %d", video.title, video.videoid);
//            NSLog(@"%d", videos.count);
//            
//        }];
//        
//        return cell;
//    } else {
        TPVideoSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:singleCellIdentifier forIndexPath:indexPath];
        cell.video = video;
        
        cell.cellDelegate = self;
        
        return cell;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = CGRectGetWidth(self.view.frame);
    TPVideoModel *video = self.videos[indexPath.section];
    
//    if (video.videoType == TPVideoAlbum) {
//        return (width / 2 - 10) / 16 * 9 + 20 + 47 + 3*30 + 2*10;
//    } else {
        return (width / 2 - 10) / 16 * 9 + 20;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TPVideoModel *video = self.videos[indexPath.section];
    TPPlayViewController *playViewController = [[TPPlayViewController alloc] init];
    [playViewController setNoteMode:TPNewNote];
    playViewController.videoDict = video.videoDict;
    
    [self.navigationController pushViewController:playViewController animated:YES];
}

#pragma mark - Favorite Delegate

- (void)didSelectFavorite:(id)sender{
    TPVideoSingleTableViewCell *cell = (TPVideoSingleTableViewCell *)sender;
    NSLog(@"%@", cell.video.videoDict[@"id"]);
    [TPVideoManager commentVideo:[[TPVideo alloc] initWithVideoDict:cell.video.videoDict]];
    [self.tableView reloadRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationFade];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
