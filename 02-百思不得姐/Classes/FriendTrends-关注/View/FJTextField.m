//
//  FJTextField.m
//  02-百思不得姐
//
//  Created by mac123 on 16/8/22.
//  Copyright © 2016年 Faniew. All rights reserved.
//

#import "FJTextField.h"
#import <objc/runtime.h>
@implementation FJTextField



//+ (void)initialize{
//    
//    unsigned int count = 0;
//
//    //拷贝出所有的属性列表
//  objc_property_t *properties= class_copyPropertyList([UITextField class], &count);
//    
//    for (NSInteger i =0; i<count; i++) {
//        objc_property_t property =properties[i];
//        
//        FJLog(@"%s %s",property_getName(property),property_getAttributes(property));
//    }
//    
//    free(properties);
//    
//}


//+  (void)initialize{
//    unsigned int count = 0;
//   //拷贝出所有的成员变量列表
//   Ivar *ivars=class_copyIvarList([UITextField class], &count);
//
//    for (NSInteger i = 0; i<count; i++) {
//
//        //取出成员变量
////        Ivar ivar = *(ivars +i);
//        Ivar ivar = ivars[i];// 数组名实际上就是指向数组首元素的指针
//
//        //打印成员变量的名字
//      FJLog(@"%s %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
//    }
//
//    //释放
//    free(ivars);
//
//}


- (void)awakeFromNib{
    //设置光标颜色
    self.tintColor = self.textColor;
    //不成为第一响应者
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder{
    
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];

}

- (BOOL)resignFirstResponder{
    
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];

    return [super resignFirstResponder];

}


/**
 * 运行时（Runtime）
 * 苹果官方的一套C语言库 
 * 能做很多底层操作（比如 访问隐藏的一些成员变量和方法）
 */





@end
