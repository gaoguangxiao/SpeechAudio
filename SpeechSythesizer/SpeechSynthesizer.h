//
//  SpeechSynthesizer.h
//  SpeechSythesizer
//
//  Created by gaoguangxiao on 2018/7/29.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SpeechSynthesizer : NSObject

+(instancetype)shareInstance;


/**
 说某一段文字

 @param string 文字
 */
-(void)speakString:(NSString *)string;


/**
 停止说话
 */
-(void)stopSpeak;
@end
