//
//  DownRecordItem.h
//  zqyOA
//
//  Created by daoyi on 14-8-29.
//  Copyright (c) 2014年 daoyi. All rights reserved.
//

#import "BaseItem.h"
typedef enum {
    FILE_doc,
    FILE_mail,
} FileType;
@interface DownRecordItem : BaseItem
@property (nonatomic,copy) NSString *fileName;
@property (nonatomic,copy) NSString *fileUrl;
@property (nonatomic) FileType fileType;
@end
