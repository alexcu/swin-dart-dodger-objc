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


@interface SGCharacters : NSObject
{
  
}

+ (SGDirectionAngles *)character:(SGCharacter *)c  angleAtIdx:(int)index;
+ (int)character:(SGCharacter *)c  maxAngleAtIdx:(int)index;
+ (int)character:(SGCharacter *)c  minAngleAtIdx:(int)index;
+ (int)characterAnglesLength:(SGCharacter *)c;
+ (NSString *)characterCharacterName:(SGCharacter *)c;
+ (int)characterCurrentDirection:(SGCharacter *)c;
+ (int)characterCurrentState:(SGCharacter *)c;
+ (int)characterDirectionCount:(SGCharacter *)c;
+ (NSArray *)characterDirections:(SGCharacter *)c;
+ (NSString *)characterFilename:(SGCharacter *)c;
+ (NSString *)characterName:(SGCharacter *)c;
+ (SGCharacter *)characterNamed:(NSString *)name;
+ (void)character:(SGCharacter *)c  setDirection:(int)direction;
+ (void)character:(SGCharacter *)c  setState:(int)state;
+ (void)character:(SGCharacter *)c  setName:(NSString *)name;
+ (void)character:(SGCharacter *)c  setType:(NSString *)name;
+ (void)character:(SGCharacter *)c  setValue:(int)idx  to:(float)val;
+ (void)character:(SGCharacter *)c  setValueNamed:(NSString *)name  to:(float)val;
+ (BOOL)character:(SGCharacter *)c  shownLayersAt:(int)index;
+ (SGSprite *)characterSprite:(SGCharacter *)c;
+ (int)characterStateCount:(SGCharacter *)c;
+ (NSArray *)characterStates:(SGCharacter *)c;
+ (NSString *)characterType:(SGCharacter *)c;
+ (float)character:(SGCharacter *)c  valueAtIndex:(int)index;
+ (int)characterValueCount:(SGCharacter *)c;
+ (NSArray *)characterValueNames:(SGCharacter *)c;
+ (void)drawCharacter:(SGCharacter *)c;
+ (void)drawCharacterSprite:(SGCharacter *)c;
+ (void)character:(SGCharacter *)c  stationaryState:(int)stationaryState  state:(int)state;
+ (void)freeCharacter:(SGCharacter *)c;
+ (BOOL)hasCharacter:(NSString *)name;
+ (SGCharacter *)loadCharacter:(NSString *)filename;
+ (SGCharacter *)loadCharacterNamed:(NSString *)name  fromFile:(NSString *)filename;
+ (void)releaseAllCharacters;
+ (void)releaseCharacter:(NSString *)name;
+ (void)setActiveLayer:(SGCharacter *)c;
+ (void)character:(SGCharacter *)c  idx:(int)index;
+ (BOOL)updateDirectionAnimation:(SGCharacter *)c;
+ (BOOL)character:(SGCharacter *)c  stationaryState:(int)state  newState:(int)newState;








@end

