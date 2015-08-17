//
//  main.m
//  13-Computer_Rows
//
//  Created by iTaa on 15/7/13.
//  Copyright (c) 2015年 iTaa. All rights reserved.
//

#import <Foundation/Foundation.h>
NSInteger codeLineCount(NSString *path)
{
    BOOL dir = NO;
    //New 文件管理对象 该对象是单例
    NSFileManager *mgr = [NSFileManager defaultManager];
    //判断路径是否存在，返回BOOL，修改dir
    BOOL exist = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exist) {
        return 0;
    }
    if (dir) {
        int count = 0;
        NSArray *array = [mgr contentsOfDirectoryAtPath:path error:nil];
        for (NSString *fileName in array) {
            NSString *fullPath = [NSString stringWithFormat:@"%@/%@",path,fileName];
            count += codeLineCount(fullPath);
        }
        return count;
    }
    else{
        //pathExtension 获取文件扩展名 lowercaseString 转成小写
        NSString *exname = [[path pathExtension] lowercaseString];
        //如果是代码文件才进行计算
        if (![exname isEqualToString:@"h"]
              &&![exname isEqualToString:@"m"]
              &&![exname isEqualToString:@"c"]) {
            return 0;
        }
        //将文件内容保存到string utf8编码
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        //根据回车分割 放到数组
        NSArray *array = [content componentsSeparatedByString:@"\n"];
        //将字符串中的字符串用其他替换
        NSString *shortPath = [path stringByReplacingOccurrencesOfString:@"/Users/itaa/Documents/AppText" withString:@""];
        //NSLog(@"%@--%ld",shortPath,array.count);
        return array.count;
    }
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *path = @"/Users/itaa/Documents/AppText";
        //[path writeToFile:@"/Users/itaa/Documents/AppText/test/Dog123.h" atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"Hello, World!");
        NSLog(@"count = %ld",codeLineCount(path));
        
        
    }
    return 0;
}
