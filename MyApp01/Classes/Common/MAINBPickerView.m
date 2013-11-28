//  MAINBPickerView.m
//  MyTestApp
//
//  Created by Lacutos on 13/6/11.
//  Copyright (c) 2013年 Jason.Cai. All rights reserved.
//


#import "MAINBPickerView.h"

@implementation MainSliderView

@synthesize sTitle, sDone, sCancel, btnDone, btnCancel,lbTitle;
@synthesize m_SliderButton;
@synthesize m_CloseButton;
-(id) initWithFrame: (CGRect) frame {
	if (self = [super initWithFrame: frame]) {
        
        self.m_SliderButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 120, 320, 40)];
        [self.m_SliderButton setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.m_SliderButton];
        [m_SliderButton release];
        
        self.m_CloseButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 120, 320, 40)];
        [self.m_CloseButton setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.m_CloseButton];
        [self.m_CloseButton setHidden:YES];
        [self.m_CloseButton release];
        
        
        [self setBackgroundColor:[UIColor clearColor]];
        
//        [TestButton release];
        
        
//		NSMutableArray *mtaBarButtonItem = [[NSMutableArray alloc] init];
		
//		UIBarButtonItem *btnFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
//																						  target: self
//																						  action: nil];
//		
//		if ((self.sDone == nil) || [self.sDone isEqualToString: @""])
//			self.sDone = @"關閉";
//		
//		if ((self.sCancel == nil) || [self.sCancel isEqualToString: @""])
//			self.sCancel = @"打開";
//		
//		self.btnDone = [[[UIBarButtonItem alloc] initWithTitle: self.sDone
//														 style: UIBarButtonItemStyleDone
//														target: self
//														action: nil] autorelease];
//		self.btnDone.tag = 1;
//		
//		self.btnCancel = [[[UIBarButtonItem alloc] initWithTitle: self.sCancel
//														   style: UIBarButtonItemStyleBordered
//														  target: self
//														  action: nil] autorelease];
//		self.btnCancel.tag = 2;
//		
//		//加入UIBarButtonItem的順序會影響取得UIBarButtonItem Frame的正確性，目前格式是取消按鍵會在左邊，確認按鍵會在右邊，需注意
//		[mtaBarButtonItem addObject: self.btnCancel];
//		[mtaBarButtonItem addObject: btnFlexibleSpace];
//		[mtaBarButtonItem addObject: self.btnDone];
//		
//		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
//        toolbar.tag = 110;
//		toolbar.barStyle = UIBarStyleBlackOpaque;
//		[toolbar setItems: mtaBarButtonItem animated: YES];
//		[toolbar sizeToFit];
//		[self addSubview: toolbar];
//		
//		CGRect cgrDoneWidth;
//		CGRect cgrCancelWidth;
//		UIView *vcBtnView = nil;
//
//		for (UIView *subView in toolbar.subviews) {
//			//UIBarButtonItem 加入ToolBar可以使用UIControl class來判別
//			if ( [subView isKindOfClass:[UIControl class] ] ) {
//				if (vcBtnView == nil){
//					vcBtnView = subView;
//				}else {
//					if (vcBtnView.frame.origin.x < subView.frame.origin.x) {
//						cgrCancelWidth = vcBtnView.frame;
//						cgrDoneWidth = subView.frame;
//					}else {
//						cgrCancelWidth = subView.frame;
//						cgrDoneWidth = vcBtnView.frame;
//					}
//				}
//			}
//		}
//		
//		//算出Label的起始位置
//		float fLabelStartPointX = cgrCancelWidth.origin.x + cgrCancelWidth.size.width;
//		//算出Label的寬度
//		float fLabelWidth = 320 - fLabelStartPointX - (320 - cgrDoneWidth.origin.x);
//		// 若有設定「標題」才加入 UILabel
//		if ((self.sTitle != nil) && (! [self.sTitle isEqualToString: @""])) {
//			UILabel *lblTitle = [[UILabel alloc] initWithFrame: CGRectMake(fLabelStartPointX, 0.0, fLabelWidth, 44.0)];
//			lblTitle.backgroundColor = [UIColor clearColor];
//			lblTitle.adjustsFontSizeToFitWidth = YES;
//			lblTitle.textColor = [UIColor whiteColor];
//			lblTitle.textAlignment = NSTextAlignmentCenter;
//			lblTitle.shadowColor = [UIColor grayColor];
//			lblTitle.shadowOffset = CGSizeMake(1.0, 1.0);
//			lblTitle.font = [UIFont boldSystemFontOfSize: 18];
//			lblTitle.text = self.sTitle;
//			self.lbTitle = lblTitle;
//			[self addSubview: lblTitle];
//			[lblTitle release];
//		}
//		[btnFlexibleSpace release];
//		[mtaBarButtonItem release];
//		[toolbar release];
	}
	
	return self;
}

-(void) drawRect: (CGRect) rect {
}

-(void) reSetMMBPickerViewTitle:(NSString *)sItemTitle {
	self.lbTitle.text = sItemTitle;
}
-(void) removeCancelBtn
{
    UIToolbar* toolbar = (UIToolbar*)[self viewWithTag:110];
    NSMutableArray *toolbarButtons = [toolbar.items mutableCopy];
    [toolbarButtons removeObject:self.btnCancel];
    toolbar.items = toolbarButtons;
}

-(void) AddCancelBtn
{
    UIToolbar* toolbar = (UIToolbar*)[self viewWithTag:110];
    NSMutableArray *toolbarButtons = [toolbar.items mutableCopy];
    [toolbarButtons insertObject:self.btnCancel atIndex:0];
    
//    [toolbarButtons addObject:self.btnCancel];
//    [toolbarButtons removeObject:self.btnCancel];
    toolbar.items = toolbarButtons;
}


-(void) removeDoneBtn
{
    UIToolbar* toolbar = (UIToolbar*)[self viewWithTag:110];
    NSMutableArray *toolbarButtons = [toolbar.items mutableCopy];
    [toolbarButtons removeObject:self.btnDone];
    toolbar.items = toolbarButtons;
}


-(void) dealloc {
	[self.sTitle release];
	[self.sDone release];
	[self.sCancel release];
	[self.btnDone release];
	[self.btnCancel release];
	[super dealloc];
}

@end