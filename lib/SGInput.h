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


@interface SGInput : NSObject
{
  
}

+ (float)getAccelerometerThreshold;
+ (void)setAccelerometerThreshold:(float)value;
+ (BOOL)anyKeyPressed;
+ (float)deviceMovedInXAxis;
+ (float)deviceMovedInYAxis;
+ (float)deviceMovedInZAxis;
+ (NSString *)endReadingText;
+ (NSArray *)fingersOnScreen;
+ (void)hideKeyboard;
+ (void)hideMouse;
+ (BOOL)keyDown:(key_code)key;
+ (NSString *)keyName:(key_code)key;
+ (BOOL)keyReleased:(key_code)key;
+ (BOOL)keyTyped:(key_code)key;
+ (BOOL)keyUp:(key_code)key;
+ (BOOL)keyboardShown;
+ (BOOL)mouseClicked:(mouse_button)button;
+ (BOOL)mouseDown:(mouse_button)button;
+ (SGVector *)mouseMovement;
+ (SGPoint2D *)mousePosition;
+ (SGVector *)mousePositionAsVector;
+ (BOOL)mouseShown;
+ (BOOL)mouseUp:(mouse_button)button;
+ (float)mouseX;
+ (float)mouseY;
+ (void)moveMouseToPoint:(SGPoint2D *)point;
+ (void)moveMouseToX:(unsigned char)x  y:(unsigned char)y;
+ (int)numberOfFingersOnScreen;
+ (void)processEvents;
+ (BOOL)readingText;
+ (BOOL)screenTouched;
+ (void)showKeyboard;
+ (void)showMouse;
+ (void)showMouse:(BOOL)show;
+ (void)startReadingTextColor:(color)textColor  maxLen:(int)maxLength  font:(SGFont *)theFont  area:(SGRectangle *)area;
+ (void)startReadingTextColor:(color)textColor  maxLen:(int)maxLength  font:(SGFont *)theFont  x:(int)x  y:(int)y;
+ (void)startReadingTextWith:(NSString *)text  color:(color)textColor  maxLen:(int)maxLength  font:(SGFont *)theFont  at:(SGPoint2D *)pt;
+ (void)startReadingTextWith:(NSString *)text  color:(color)textColor  maxLen:(int)maxLength  font:(SGFont *)theFont  area:(SGRectangle *)area;
+ (void)startReadingTextWith:(NSString *)text  color:(color)textColor  bgColor:(color)backGroundColor  maxLen:(int)maxLength  font:(SGFont *)theFont  area:(SGRectangle *)area;
+ (void)startReadingTextWith:(NSString *)text  color:(color)textColor  maxLen:(int)maxLength  font:(SGFont *)theFont  x:(int)x  y:(int)y;
+ (BOOL)textEntryCancelled;
+ (NSString *)textReadAsASCII;
+ (void)toggleKeyboard;
+ (BOOL)windowCloseRequested;








@end

