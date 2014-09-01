//
//  DownLoadFileCenter.h
//  zqyOA
//
//  Created by daoyi on 14-9-1.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseViewController.h"
#import "DownRecordItem.h"

#import <ASINetworkQueue.h>



@protocol DownLoadFileCenterDelegate;

@interface DownLoadFileCenter : BaseViewController
@property (nonatomic,weak) id<DownLoadFileCenterDelegate> delegate;

@end

@protocol DownLoadFileCenterDelegate <NSObject>
@optional
-(void)DownloadFileDidStart:(DownLoadFileCenter *)downLoad fileRecord:(DownRecordItem *)aFile;
-(void)DownloadFileDidFaild:(DownLoadFileCenter *)downLoad fileRecord:(DownRecordItem *)aFile;
-(void)DownloadFileDidFinished:(DownLoadFileCenter *)downLoad fileRecord:(DownRecordItem *)aFile;
-(void)DownloadFileBytesReceived:(NSNumber *)size totalSize:(NSNumber *)total fileRecord:(DownRecordItem *)aFile;

@end