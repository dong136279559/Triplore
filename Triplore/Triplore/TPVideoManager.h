//
//  TPVideoManager.h
//  Triplore
//
//  Created by 宋 奎熹 on 2017/6/1.
//  Copyright © 2017年 宋 奎熹. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TPVideo;

@interface TPVideoManager : NSObject

/**
 插入视频

 @param video 视频
 @return 是否插入成功
 */
+ (BOOL)insertVideo:(TPVideo *_Nonnull)video;

/**
 根据 id 得到视频

 @param videoid 视频 id
 @return  视频
 */
+ (TPVideo *_Nullable)fetchVideoWithID:(NSString *_Nonnull)videoid;

#pragma mark - Favorite Videos

/**
 （取消）收藏/喜爱一个视频

 @param video 视频
 @return 是否（取消）收藏/喜爱成功
 */
+ (BOOL)commentVideo:(TPVideo *_Nonnull)video;

/**
 是否是收藏的视频

 @param videoid 视频 id
 @return  是否为收藏视频
 */
+ (BOOL)isFavoriteVideo:(NSString *_Nonnull)videoid;

/**
 得到所有喜爱的视频

 @return 喜爱的视频数组
 */
+ (NSArray<TPVideo *> *_Nullable)fetchFavoriteVideos;

#pragma mark - Recent Videos

/**
 得到最近观看视频

 @return 最近观看的视频数组
 */
+ (NSArray<TPVideo *> *_Nullable)fetchRecentVideos;

/**
 删除最近观看视频

 @param videoid 视频
 @return 是否删除成功
 */
+ (BOOL)deleteRecentVideo:(NSString *_Nonnull)videoid;

/**
 清空最近观看记录

 @return 是否清空成功
 */
+ (BOOL)clearRecentRecord;

@end
