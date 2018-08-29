//
//  Emoticon.m
//  HLEmoji
//
//  Created by 靓萌服饰靓萌服饰 on 2018/8/28.
//  Copyright © 2018年 靓萌服饰靓萌服饰. All rights reserved.
//

#import "Emoticon.h"

@implementation Emoticon
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(Emoticon *)initwithDic:(NSDictionary *)dic{
    Emoticon *emoticon=[[Emoticon alloc ] init];
    [emoticon setValuesForKeysWithDictionary:dic];
    return emoticon;
}
-(void)setCode:(NSString *)code{
  NSScanner *scanner=  [NSScanner scannerWithString:code];
    
}
@end
@implementation EmoticonGroup

@end
