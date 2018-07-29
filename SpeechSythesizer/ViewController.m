//
//  ViewController.m
//  SpeechSythesizer
//
//  Created by gaoguangxiao on 2018/7/29.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "ViewController.h"

#import "SpeechSynthesizer.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    SpeechSynthesizer *speech = [SpeechSynthesizer shareInstance];
//    
//    NSLog(@"%p",speech);
//    
//    [speech speakString:@"测试驱动开发并不是一个很新鲜的概念了"];
//    
//    SpeechSynthesizer *speech1 = [SpeechSynthesizer shareInstance];
//    NSLog(@"%p",speech1);
}
- (IBAction)startSpeak:(id)sender {
    [[SpeechSynthesizer shareInstance]speakString:@"床前明月光，疑是地上霜。举头望明月，低头思故乡"];
}
- (IBAction)stopSpeak:(id)sender {
    [[SpeechSynthesizer shareInstance]stopSpeak];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
