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


@interface SGsgArduino : NSObject
{
  
}

+ (SGArduinoDevice *)arduinoDeviceNamed:(NSString *)name;
+ (BOOL)arduinoHasData:(SGArduinoDevice *)dev;
+ (unsigned char)arduinoReadByte:(SGArduinoDevice *)dev;
+ (unsigned char)arduinoReadByte:(SGArduinoDevice *)dev  timeout:(int)timeout;
+ (NSString *)arduinoReadLine:(SGArduinoDevice *)dev;
+ (NSString *)arduinoReadLine:(SGArduinoDevice *)dev  timeout:(int)timeout;
+ (void)arduinoSendByte:(SGArduinoDevice *)dev  value:(unsigned char)value;
+ (void)arduinoSendString:(SGArduinoDevice *)dev  value:(NSString *)value;
+ (void)arduinoSendStringLine:(SGArduinoDevice *)dev  value:(NSString *)value;
+ (SGArduinoDevice *)createArduinoOnPort:(NSString *)port  atBaud:(int)baud;
+ (SGArduinoDevice *)createArduinoNamed:(NSString *)name  onPort:(NSString *)port  atBaud:(int)baud;
+ (void)ArduinoCloseConnection:(SGArduinoDevice *)dev;
+ (BOOL)hasArduinoDevice:(NSString *)name;
+ (void)releaseAllArduinoDevices;
+ (void)releaseArduinoDevice:(NSString *)name;








@end

