#import "SGPanel.h"

#import <stdlib.h>

#import "SGSDK.h"
#import "SwinGame.h"

@implementation SGPanel : NSObject

+ (void) getPanels:(panel *)firstPtr fromArray:(NSArray *)in_data maxSize:(int)sz
{
    int i;
    int count = [in_data count];
    count = count <= sz ? count : sz; //get min of sz and count
    for ( i = 0; i < count; i++ ) 
    {
        SGPanel *obj = [in_data objectAtIndex:i];
        *(firstPtr + i) = obj->pointer;
    }
}

+ (NSArray *) arrayOfPanels:(panel *)firstPtr size:(int)sz
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:sz];
    int i;
    SGPanel *obj;
    
    for (i = 0; i < sz; i++)
    {
        obj = [SGPanel createWithId: *(firstPtr + i)];
        [result addObject: obj];
    }
    
    return [result autorelease];
}

+ (id)createWithId:(panel)ptr
{
    if (ptr == nil) return nil;
    id obj = [PointerManager objectForKey: (id)ptr];
    
    if (obj == nil)
    {
        // Create and assign to obj...
        obj = [[[self alloc] initWithId:ptr] autorelease];
    }
    
    return obj;
}

- (id)initWithId:(panel)ptr
{
    if (ptr == nil)
    {
        [self release];
        return nil;
    }
    //Assign super's initialised value to the self pointer
    self = [super init];
    if (self != nil)
    {
        //If self isn't nil then assign pointer.
        pointer = ptr;
        [PointerManager registerObject:self withKey:(id)ptr];
    }
    return self;
}

- (void)releasePointer
{
    pointer = nil;
}



- (id)initFromFile:(NSString *)filename
{
    char filename_temp[[filename length] + 1];
    SGPanel * result;
    [filename getCString:filename_temp maxLength:[filename length] + 1 encoding:NSASCIIStringEncoding];
    result = [self initWithId: sg_UserInterface_LoadPanel(filename_temp)];
    return result;
}

- (id)initWithName:(NSString *)name  fromFile:(NSString *)filename
{
    char name_temp[[name length] + 1];
    char filename_temp[[filename length] + 1];
    SGPanel * result;
    [name getCString:name_temp maxLength:[name length] + 1 encoding:NSASCIIStringEncoding];
    [filename getCString:filename_temp maxLength:[filename length] + 1 encoding:NSASCIIStringEncoding];
    result = [self initWithId: sg_UserInterface_LoadPanelNamed(name_temp, filename_temp)];
    return result;
}



@dynamic active;
@dynamic clicked;
@dynamic draggable;
@dynamic fileName;
@dynamic height;
@dynamic isDragging;
@dynamic name;
@dynamic visible;
@dynamic width;
@dynamic x;
@dynamic y;


- (BOOL)active
{
    BOOL result;
    result = sg_UserInterface_PanelActive(self->pointer) != 0;
    return result;
}

- (BOOL)clicked
{
    BOOL result;
    result = sg_UserInterface_PanelWasClicked(self->pointer) != 0;
    return result;
}

- (BOOL)draggable
{
    BOOL result;
    result = sg_UserInterface_PanelDraggable(self->pointer) != 0;
    return result;
}

- (void)setDraggable:(BOOL)b
{
    sg_UserInterface_PanelSetDraggable(self->pointer, (b ? 1 : 0));
}

- (NSString *)fileName
{
    char result[2048];
    sg_UserInterface_PanelFilename(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (int)height
{
    int result;
    result = sg_UserInterface_PanelHeight(self->pointer);
    return result;
}

- (BOOL)isDragging
{
    BOOL result;
    result = sg_UserInterface_PanelIsDragging(self->pointer) != 0;
    return result;
}

- (NSString *)name
{
    char result[2048];
    sg_UserInterface_PanelName(self->pointer, result);
    return [[[NSString alloc] initWithCString:result encoding:NSASCIIStringEncoding] autorelease];
}

- (BOOL)visible
{
    BOOL result;
    result = sg_UserInterface_PanelVisible(self->pointer) != 0;
    return result;
}

- (int)width
{
    int result;
    result = sg_UserInterface_PanelWidth(self->pointer);
    return result;
}

- (float)x
{
    float result;
    result = sg_UserInterface_PanelX(self->pointer);
    return result;
}

- (float)y
{
    float result;
    result = sg_UserInterface_PanelY(self->pointer);
    return result;
}

- (void)activate
{
    sg_UserInterface_ActivatePanel(self->pointer);
}

- (int)activeRadioButtonIndexWithID:(NSString *)id
{
    char id_temp[[id length] + 1];
    int result;
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_ActiveRadioButtonIndexOnPanel(self->pointer, id_temp);
    return result;
}

- (BOOL)checkboxStateWithId:(NSString *)s
{
    char s_temp[[s length] + 1];
    BOOL result;
    [s getCString:s_temp maxLength:[s length] + 1 encoding:NSASCIIStringEncoding];
    result = sg_UserInterface_CheckboxStateOnPanel(self->pointer, s_temp) != 0;
    return result;
}

- (void)deactivate
{
    sg_UserInterface_DeactivatePanel(self->pointer);
}

- (void)hide
{
    sg_UserInterface_HidePanel(self->pointer);
}

- (void)move:(SGVector *)mvmt
{
    sg_UserInterface_MovePanel(self->pointer, &mvmt->data);
}

- (BOOL)pointInRegion:(SGPoint2D *)pt
{
    BOOL result;
    result = sg_UserInterface_PointInRegion(&pt->data, self->pointer) != 0;
    return result;
}

- (BOOL)point:(SGPoint2D *)pt  inRegionKind:(guielement_kind)kind
{
    BOOL result;
    result = sg_UserInterface_PointInRegionWithKind(&pt->data, self->pointer, (int)kind) != 0;
    return result;
}

- (SGRegion *)regionWithID:(NSString *)ID
{
    char ID_temp[[ID length] + 1];
    SGRegion * result;
    [ID getCString:ID_temp maxLength:[ID length] + 1 encoding:NSASCIIStringEncoding];
    result = [SGRegion createWithId:sg_UserInterface_RegionWithID(self->pointer, ID_temp)];
    return result;
}

- (void)selectRadioButton:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_SelectRadioButtonOnPanelWithId(self->pointer, id_temp);
}

- (void)show
{
    sg_UserInterface_ShowPanel(self->pointer);
}

- (void)showDialog
{
    sg_UserInterface_ShowPanelDialog(self->pointer);
}

- (void)toggleActivate
{
    sg_UserInterface_ToggleActivatePanel(self->pointer);
}

- (void)toggleCheckBoxWithID:(NSString *)id
{
    char id_temp[[id length] + 1];
    [id getCString:id_temp maxLength:[id length] + 1 encoding:NSASCIIStringEncoding];
    sg_UserInterface_ToggleCheckboxStateOnPanel(self->pointer, id_temp);
}

- (void)toggleVisible
{
    sg_UserInterface_ToggleShowPanel(self->pointer);
}

- (void)free
{
    sg_UserInterface_FreePanel(&self->pointer);
}


@end
