//
//  YJYComposeViewController.m
//  Weibo
//
//  Created by yaojinye on 16/7/8.
//  Copyright (c) 2016年 yaojinye. All rights reserved.
//

#import "YJYComposeViewController.h"
#import "YJYComposeView.h"
#import "YJYComposeToolBar.h"
#import "YJYComposePhotosView.h"
#import "YJYComposeTool.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "YJYComposeParam.h"
#import "MJExtension.h"


@interface YJYComposeViewController ()<UITextViewDelegate, YJYComposeToolDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak)YJYComposeView *composeView;
@property (nonatomic, weak)YJYComposeToolBar *toolBar;
@property (nonatomic, weak)YJYComposePhotosView *photosView;
@property (nonatomic, strong)UIBarButtonItem *composeBtn;
@property (nonatomic, strong)NSMutableArray *images;

@end

@implementation YJYComposeViewController


-(NSMutableArray *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupNavigationbar];
    
    [self setupComposeView];
    
    [self setupToolBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setupPhotosView];
}

-(void)setupPhotosView{
    YJYComposePhotosView *photosView = [[YJYComposePhotosView alloc]initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height - 70)];
//    photosView.backgroundColor = [UIColor redColor];
    _photosView = photosView;
    [_composeView addSubview:photosView];
    
}

-(void)keyboardFrameChange:(NSNotification *)note{
    NSLog(@"%@", note);
    
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] floatValue];
    
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.height) {
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformIdentity;
        }];
    }else{
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}

-(void)setupToolBar{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    YJYComposeToolBar *toolBar = [[YJYComposeToolBar alloc]initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
}

-(void)setupComposeView{
    YJYComposeView *composeView = [[YJYComposeView alloc]initWithFrame:self.view.bounds];
    
    composeView.placeholder = @"分享新鲜事...";
    composeView.font = [UIFont systemFontOfSize:15];

    _composeView = composeView;
    [self.view addSubview:composeView];
    
    _composeView.delegate = self;
    _composeView.alwaysBounceVertical = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];

}

-(void)textChange{
    if (_composeView.text.length) {
        _composeView.hidePlaceholder = YES;
        _composeBtn.enabled = YES;
    }else{
        _composeView.hidePlaceholder = NO;
        _composeBtn.enabled = NO;
    }
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_composeView becomeFirstResponder];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
}

-(void)setupNavigationbar{

    self.title = @"发微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];

    UIBarButtonItem *rightItem= [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    _composeBtn = rightItem;
    _composeBtn.enabled = NO;
}


-(void)composeToolBar:(YJYComposeToolBar *)toolBar btnClickedIndex:(NSInteger)index{
    if (index == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    
    _photosView.image = image;
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    _composeBtn.enabled = YES;
    
}


-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)compose{

    if (self.images.count) {
        
        UIImage *image = self.images[0];
        
        NSString *status = _composeView.text.length? _composeView.text : @"分享图片";
        YJYComposeParam *param = [YJYComposeParam param];
        param.status = status;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.mj_keyValues constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            NSData *data = UIImagePNGRepresentation(image);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"image.png" mimeType:@"image/png"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [MBProgressHUD showSuccess:@"发送图片成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
            NSLog(@"%@", error);
            
        }];
        
    }else{
        
        [self sendText];
    }
    
    
}

-(void)sendText{
    
    [YJYComposeTool composeWithStatus:_composeView.text success:^{
        NSLog(@"Compose Success");
        
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD showError:@"Failure Compose"];
    }];
    

}

@end
