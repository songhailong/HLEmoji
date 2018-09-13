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
-(void)setIsRemove:(BOOL)isRemove{
    _isRemove=isRemove;
    if (_isRemove) {
        _type=EmoticonTypeRemove;
    }
}
-(void)setCode:(NSString *)code{
    _code=code;
//  NSScanner *scanner=  [NSScanner scannerWithString:code];
//    uint32_t result=0;
//    [scanner scanHexInt:&result];
    //_emotionStr=
    unsigned unicode = 0;
    [[NSScanner scannerWithString:code]scanHexInt:&unicode];
    
    char chars[4];
    
    int len = 4;
    
    chars[0] = (unicode >> 24) & (1<<24) -1;
    chars[1] = (unicode >> 16) & (1<<16)-1;
    chars[2] =  (unicode >> 8) & (1<<8) -1;
    chars[3] = unicode & (1<<8) -1;
    
    NSString * unicodeString = [[NSString alloc]initWithBytes:chars length:len encoding:NSUTF32StringEncoding];
    _emotionStr=unicodeString;
}
@end
@implementation EmoticonGroup
-(void)setGroupID:(NSString *)groupID{
    _groupID=groupID;
    if ([groupID containsString:@"default"]) {
        _nameCN=@"默认";
        _groupType=EmoticonTypeImage;
    }else if ([groupID containsString:@"emoji"]){
        _nameCN=@"emoji";
        _groupType=EmoticonTypeEmoji;
    }else if ([groupID containsString:@"lxh"]){
        _nameCN=@"浪小花";
        _groupType=EmoticonTypeImage;
    }
}
-(void)setEmoticons:(NSMutableArray<Emoticon *> *)emoticons{
    _emoticons=emoticons;
    //追加空白
    int count=emoticons.count%21;
    _numberOfPage=emoticons.count/21;
    if (count>0) {
        _numberOfPage=_numberOfPage+1;
    
    NSLog(@"个数%d",count);
    for (int i=count;i<20;i++) {
        NSLog(@"i=%d",i);
        Emoticon *emo=[[Emoticon  alloc] init];
        emo.isRemove=NO;
        [_emoticons addObject:emo];
        //NSLog(@"抓奸");
    }
    Emoticon *emor=[[Emoticon  alloc] init];
    emor.isRemove=YES;
    [_emoticons addObject:emor];
    }
}
@end
