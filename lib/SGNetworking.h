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


@interface SGNetworking : NSObject
{
  
}

+ (int)acceptTCPConnection;
+ (void)broadcastTCPMessage:(NSString *)aMsg;
+ (void)broadcastUDPMessage:(NSString *)aMsg;
+ (void)clearMessageQueue:(SGConnection *)aConnection;
+ (void)closeAllConnections;
+ (void)closeAllSockets;
+ (void)closeAllTCPHostSockets;
+ (void)closeAllUDPSockets;
+ (BOOL)closeConnection:(SGConnection *)aConnection;
+ (BOOL)closeTCPHostSocketPort:(int)aPort;
+ (BOOL)closeUDPSocket:(int)aPort;
+ (int)connectionCount;
+ (uint)connectionIP:(SGConnection *)aConnection;
+ (int)connectionPort:(SGConnection *)aConnection;
+ (int)connectionQueueSize;
+ (SGConnection *)createTCPConnection:(NSString *)aIP  port:(int)aPort;
+ (BOOL)createTCPHost:(int)aPort;
+ (SGConnection *)createUDPConnectionIP:(NSString *)aDestIP  port:(int)aDestPort  inPort:(int)aInPort;
+ (int)createUDPHost:(int)aPort;
+ (NSString *)decToHex:(uint)aDec;
+ (void)enqueueMessage:(NSString *)aMsg  toConnection:(SGConnection *)aConnection;
+ (void)enqueueNewConnection:(SGConnection *)aConnection;
+ (SGConnection *)fetchConnection;
+ (void)freeConnection:(SGConnection *)aConnection;
+ (NSString *)hexStrToIPv4:(NSString *)aHex;
+ (NSString *)hexToDecString:(NSString *)aHex;
+ (uint)iPv4ToDec:(NSString *)aIP;
+ (int)messageCountOnConnection:(SGConnection *)aConnection;
+ (NSString *)myIP;
+ (NSString *)readLastMessage:(SGConnection *)aConnection;
+ (NSString *)readMessage:(SGConnection *)aConnection;
+ (void)releaseAllConnections;
+ (SGConnection *)retreiveConnection:(int)aConnectionAt;
+ (SGConnection *)sendTCPMessage:(NSString *)aMsg  toConnection:(SGConnection *)aConnection;
+ (BOOL)sendUDPMessage:(NSString *)aMsg  toConnection:(SGConnection *)aConnection;
+ (BOOL)tCPMessageReceived;
+ (BOOL)uDPMessageReceived;








@end

