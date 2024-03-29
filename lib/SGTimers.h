#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "SGPoint2D.h"
#import "SGVector.h"
#import "SGRectangle.h"
#import "SGFinger.h"
#import "SGResolution.h"
#import "SGCircle.h"
#import "SGAccelerometerMotion.h"
#import "SGLineSegment.h"
#import "SGTriangle.h"
#import "SGSoundEffect.h"
#import "SGMusic.h"
#import "SGMatrix2D.h"
#import "SGAnimationScript.h"
#import "SGAnimation.h"
#import "SGBitmap.h"
#import "SGBitmapCell.h"
#import "SGSprite.h"
#import "SGTimer.h"
#import "SGFont.h"
#import "SGDirectionAngles.h"
#import "SGCharacter.h"
#import "SGGUIList.h"
#import "SGGUILabel.h"
#import "SGGUICheckbox.h"
#import "SGPanel.h"
#import "SGRegion.h"
#import "SGGUITextbox.h"
#import "SGGUIRadioGroup.h"
#import "SGConnection.h"
#import "SGArduinoDevice.h"


@interface SGTimers : NSObject
{
  
}

+ (SGTimer *)init;
+ (SGTimer *)initWithName:(NSString *)name;
+ (void)freeTimer:(SGTimer *)toFree;
+ (void)pauseTimer:(SGTimer *)toPause;
+ (void)releaseAllTimers;
+ (void)releaseTimer:(NSString *)name;
+ (void)resetTimer:(SGTimer *)tmr;
+ (void)resumeTimer:(SGTimer *)toUnpause;
+ (void)startTimer:(SGTimer *)toStart;
+ (void)stopTimer:(SGTimer *)toStop;
+ (SGTimer *)timerNamed:(NSString *)name;
+ (uint)timerTicks:(SGTimer *)toGet;








@end

