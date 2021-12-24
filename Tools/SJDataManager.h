//
//  SJDataManager.h
//  AnJian
//
//  Created by Air on 2021/9/9.
//
// 存数据->NSUserDefaults，这里实现的是NSData数据的存取删，编解码由SJArchiver完成
#import "SJArchiver.h"
#define kUserDefaults [NSUserDefaults standardUserDefaults]
NS_ASSUME_NONNULL_BEGIN

@interface SJDataManager : SJArchiver

@end

NS_ASSUME_NONNULL_END
