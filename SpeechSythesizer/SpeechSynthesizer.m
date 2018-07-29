//
//  SpeechSynthesizer.m
//  SpeechSythesizer
//
//  Created by gaoguangxiao on 2018/7/29.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "SpeechSynthesizer.h"


static SpeechSynthesizer *_instance;

@interface SpeechSynthesizer(){
    
}
@property(nonatomic,strong)AVSpeechSynthesizer *speechSynthesizer;
@end

@implementation SpeechSynthesizer
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

#pragma mark - 实例化演讲属性
-(AVSpeechSynthesizer *)speechSynthesizer{
    if (!_speechSynthesizer) {
        _speechSynthesizer = [[AVSpeechSynthesizer alloc]init];
    }
    return _speechSynthesizer;
}

-(void)speakString:(NSString *)string{
    //加一个实现后台播放的
    AVAudioSession *audioSession  = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:NULL];
    
    AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];//被播放的一段语音文字，可以理解为一段需要播放的文字
    [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];//设置语言
    
    //iOS语音合成在iOS8及以下版本系统上语速异常
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
    {
        aUtterance.rate = 0.25;//iOS7设置为0.25 文字播放的语速
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)
    {
        aUtterance.rate = 0.15;//iOS8设置为0.15
    }
    
    //如果说话中，先停止
    if ([self.speechSynthesizer isSpeaking]){
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    
    [self.speechSynthesizer speakUtterance:aUtterance];//添加一个播放话语到播放语音队列，可以设置Utterance属性控制播放
}
-(void)stopSpeak{
    //    AVSpeechBoundaryImmediate 立即停止
//    AVSpeechBoundaryWord  说完一个词语在停止
    [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}
@end
