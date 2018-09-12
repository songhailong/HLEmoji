//
//  Emoticon.h
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,EmoticonType) {
    EmoticonTypeImage = 0, ///< 图片表情
    EmoticonTypeEmoji = 1, ///< Emoji表情
};
@interface Emoticon : NSObject
@property(nonatomic,strong)NSString *chs;//
@property (nonatomic, strong) NSString *cht;
@property (nonatomic, strong) NSString *gif;
@property (nonatomic, strong) NSString *png;
@property (nonatomic, strong) NSString *code;///< 例如 0x1f60d
@property (nonatomic, assign) EmoticonType type;
@property(nonatomic,strong)NSString *groupid;
@property(nonatomic,strong)NSString *imagePath;
@property(nonatomic,strong)NSString *emotionStr;
+(Emoticon *)initwithDic:(NSDictionary *)dic;
@end
@interface EmoticonGroup :NSObject

/**
    id 表示
 */
@property (nonatomic, strong) NSString *groupID; ///< 例如 com.sina.default
@property (nonatomic, strong) NSNumber *version;
@property (nonatomic, strong) NSString *nameCN; ///< 例如 浪小花
@property (nonatomic, strong) NSString *nameEN;
@property (nonatomic, strong) NSString *nameTW;
@property (nonatomic, strong )NSNumber *displayOnly;
@property (nonatomic, assign) NSInteger groupType;
@property (nonatomic, strong) NSArray<Emoticon *> *emoticons;
@end
