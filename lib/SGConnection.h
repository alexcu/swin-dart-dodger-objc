#import <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

#import "Types.h"
#import "SGTypes.h"
#import "PointerManager.h"


@interface SGConnection : NSObject <PointerWrapper>
{
@package
    connection pointer;
}

+ (NSArray *) arrayOfConnections:(connection *)firstPtr size:(int)sz;
+ (void) getConnections:(connection *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz;
+ (id)createWithId:(connection)ptr;

- (id)initWithId:(connection)ptr; 





- (void)clearMessageQueue;
- (BOOL)close;
- (uint)connectionIP;
- (int)connectionPort;
- (void)enqueueMessage:(NSString *)aMsg;
- (void)enqueueNewConnection;
- (int)messageCount;
- (NSString *)readLastMessage;
- (NSString *)readMessage;
- (SGConnection *)sendTCPMessage:(NSString *)aMsg;
- (BOOL)sendUDPMessage:(NSString *)aMsg;
- (void)free;
@end
