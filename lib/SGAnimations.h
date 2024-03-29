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


@interface SGAnimations : NSObject
{
  
}

+ (int)animationCurrentCell:(SGAnimation *)anim;
+ (SGVector *)animationCurrentVector:(SGAnimation *)anim;
+ (BOOL)animationEnded:(SGAnimation *)anim;
+ (BOOL)animationEnteredFrame:(SGAnimation *)anim;
+ (float)animationFrameTime:(SGAnimation *)anim;
+ (int)animationScript:(SGAnimationScript *)temp  indexOfAnimation:(NSString *)name;
+ (NSString *)animationScript:(SGAnimationScript *)temp  nameOfAnimation:(int)idx;
+ (NSString *)animationScriptName:(SGAnimationScript *)script;
+ (SGAnimationScript *)animationScriptNamed:(NSString *)name;
+ (void)assignAnimationNamed:(SGAnimation *)anim  to:(NSString *)name  from:(SGAnimationScript *)script;
+ (void)assignAnimation:(SGAnimation *)anim  to:(int)idx  from:(SGAnimationScript *)script;
+ (void)assignAnimationNamed:(SGAnimation *)anim  to:(NSString *)name  from:(SGAnimationScript *)script  withSound:(BOOL)withSound;
+ (void)assignAnimation:(SGAnimation *)anim  to:(int)idx  from:(SGAnimationScript *)script  withSound:(BOOL)withSound;
+ (SGAnimation *)animationAtIndex:(int)identifier  from:(SGAnimationScript *)script;
+ (SGAnimation *)animationNamed:(NSString *)identifier  from:(SGAnimationScript *)script;
+ (SGAnimation *)animationAtIndex:(int)identifier  from:(SGAnimationScript *)script  withSound:(BOOL)withSound;
+ (SGAnimation *)animationNamed:(NSString *)identifier  from:(SGAnimationScript *)script  withSound:(BOOL)withSound;
+ (void)drawAnimation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  pt:(SGPoint2D *)pt;
+ (void)drawAnimation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  x:(int)x  y:(int)y;
+ (void)drawOnto:(SGBitmap *)dest  animation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  pt:(SGPoint2D *)pt;
+ (void)drawOnto:(SGBitmap *)dest  animation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  x:(int)x  y:(int)y;
+ (void)drawAnimation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  onScreenAtPt:(SGPoint2D *)pt;
+ (void)drawAnimation:(SGAnimation *)ani  bitmap:(SGBitmap *)bmp  onScreenAtX:(int)x  y:(int)y;
+ (void)freeAnimation:(SGAnimation *)ani;
+ (void)freeAnimationScript:(SGAnimationScript *)scriptToFree;
+ (BOOL)hasAnimationScript:(NSString *)name;
+ (SGAnimationScript *)loadAnimationScriptFromFile:(NSString *)filename;
+ (SGAnimationScript *)loadAnimationScriptNamed:(NSString *)name  fromFile:(NSString *)filename;
+ (void)releaseAllAnimationScripts;
+ (void)releaseAnimationScript:(NSString *)name;
+ (void)restartAnimation:(SGAnimation *)anim;
+ (void)resetAnimation:(SGAnimation *)anim  withSound:(BOOL)withSound;
+ (void)updateAnimation:(SGAnimation *)anim;
+ (void)updateAnimation:(SGAnimation *)anim  pct:(float)pct;
+ (void)updateAnimation:(SGAnimation *)anim  pct:(float)pct  withSound:(BOOL)withSound;








@end

