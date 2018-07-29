# SpeechAudio


一、AVAudioSession
二、AVSpeechSynthesizer
三、AVSpeechUtterance
使用AVAudioSession负责调解APP和iOS系统里面的行为，比如其他APP播放声音的时候，闹钟、电话中断，耳机插拔。
使用AVSpeechSynthesizer演讲播放器播放语音，比如某一段文字，用于地图语音导航，文字转声音
使用AVSpeechUtterance，将一段文字准备成一段可供硬件理解，设置语音的停顿，语速，语音种类等方法

一、AVAudioSession
引入链接
iOS音频AVAudioSession：https://www.jianshu.com/p/fb0e5fb71b3c
由AVFoundation框架引入，每个iOS应用都有一个音频会话，用来管理多个APP对音频硬件设备的资源使用，其在APP启动的时候会自动帮忙激活它，这个会话可以被AVAudioSession类sharedInstance类方法访问，如下：
AVAudioSession*audioSession = [AVAudioSession sharedInstance];
1、作用
设置自己的APP是否和其他APP音频同时存在，还是中断其他APP的声音。
手机静音模式，自己APP是否还可以发出声音
电话或者其他APP中断自己的APP的音频处理
指定音频输入和输出的设备（比如是听筒输出声音还是扬声器输出声音）
是否支持录音，录音的同时是否支持音频播放

在获得一个AVAudioSession类的实例后，你就能通过调用音频会话对象的setCategory:error:实例方法，来从IOS应用可用的不同类别中作出选择。下面列出了可供使用的音频会话类别

其中Category分别有四种方法，是否打断不支持混音播放的APP，
是否会相应手机静音模式的开关
是否支持音频录制
是否支持音频播放

Category用于用于大方向
mode用于定制Cagegory的行为，录制视频，视频播放，视频通话
options用于微调和其他APP的关系，比如压制其他APP音调的响度

音频中断处理：
中断开始：记录此时APP状态，如播放状态，界面状态
中断结束：恢复APP的状态

二、AVSpeechSynthesizer
借用这个类，可以很方便实现从文本到语音播报的功能。
self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];

- (void)speakUtterance:(AVSpeechUtterance *)utterance;

/* These methods will operate on the speech utterance that is speaking. Returns YES if it succeeds, NO for failure. */

/* Call stopSpeakingAtBoundary: to interrupt current speech and clear the queue. */
- (BOOL)stopSpeakingAtBoundary:(AVSpeechBoundary)boundary;
- (BOOL)pauseSpeakingAtBoundary:(AVSpeechBoundary)boundary;
- (BOOL)continueSpeaking;

三、AVSpeechUtterance
NS_CLASS_AVAILABLE_IOS(7_0)
@interface AVSpeechUtterance : NSObject<NSCopying, NSSecureCoding>

+ (instancetype)speechUtteranceWithString:(NSString *)string;
+ (instancetype)speechUtteranceWithAttributedString:(NSAttributedString *)string API_AVAILABLE(ios(10.0), watchos(3.0), tvos(10.0));

- (instancetype)initWithString:(NSString *)string;
- (instancetype)initWithAttributedString:(NSAttributedString *)string API_AVAILABLE(ios(10.0), watchos(3.0), tvos(10.0));

/* If no voice is specified, the system's default will be used. */
@property(nonatomic, retain, nullable) AVSpeechSynthesisVoice *voice;

@property(nonatomic, readonly) NSString *speechString;
@property(nonatomic, readonly) NSAttributedString *attributedSpeechString API_AVAILABLE(ios(10.0), watchos(3.0), tvos(10.0));

/* Setting these values after a speech utterance has been enqueued will have no effect. */

@property(nonatomic) float rate;             // Values are pinned between AVSpeechUtteranceMinimumSpeechRate and AVSpeechUtteranceMaximumSpeechRate.
@property(nonatomic) float pitchMultiplier;  // [0.5 - 2] Default = 1
@property(nonatomic) float volume;           // [0-1] Default = 1

@property(nonatomic) NSTimeInterval preUtteranceDelay;    // Default is 0.0
@property(nonatomic) NSTimeInterval postUtteranceDelay;   // Default is 0.0


@end
