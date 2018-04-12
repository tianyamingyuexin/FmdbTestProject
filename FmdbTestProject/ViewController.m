//
//  ViewController.m
//  FmdbTestProject
//
//  Created by guangshu01 on 2018/2/10.
//  Copyright © 2018年 guangshu01. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "FmdbTool.h"
#import "PersonInfoModel.h"
#import "FmdbTool.h"
#import "SAMKeychain.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
    
}
- (IBAction)saveStringAction:(id)sender
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myFile.plist"];
    
    NSError *err = nil;
    
    //writeToFile把字符串存入文件。第一个参数表示存储的路径(包含文件名),第二个参数表示是否原子性写入(如果多个线程可能同时操作这个文件，原子性需要写YES)，第三个参数表示文本的编码方式(字符串存储到硬盘上必须先转换为二进制数据，选择按照哪种编码格式进行编码)。第四个参数表示如果存储失败，失败的原因。
    if (![@"天涯明月新，朝暮最相思" writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:&err]) {
        NSLog(@"%@",err);
    }
}
- (IBAction)readStringAction:(id)sender
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myFile.plist"];
    //从文件中读取字符串,第一个参数，读取的文件的路径，第二个参数编码方式，第三个参数，如果失败，失败的原因。
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",text);
}

- (IBAction)saveArrayAction:(id)sender
{
    NSArray *array = @[@"惟将长夜未开眼",@"报答平生未展眉"];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/array.plist"];
    
    //把数组存入文件
    [array writeToFile:path atomically:NO];
}

- (IBAction)readArrayAction:(id)sender
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/array.plist"];
    //从文件中读取数组
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    

    for (NSString *strs in array)
    {
            NSLog(@"%@",strs);
    }
}

- (IBAction)saveUserDefault:(id)sender
{
    //1.获得NSUserDefaults文件
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //2.向文件中写入内容
    [userDefaults setObject:@"AAA" forKey:@"a"];
    [userDefaults setBool:YES forKey:@"sex"];
    [userDefaults setInteger:21 forKey:@"age"];
    //2.1立即同步
    [userDefaults synchronize];
    //3.读取文件
    NSString *name = [userDefaults objectForKey:@"a"];
    BOOL sex = [userDefaults boolForKey:@"sex"];
    NSInteger age = [userDefaults integerForKey:@"age"];
    NSLog(@"%@, %d, %ld", name, sex, age);
}
- (IBAction)savePerosnAction:(UIButton *)sender
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/person.plist"];

    Person *person = [[Person alloc] init];
    person.avatar = [UIImage imageNamed:@"ss"];
    person.name = @"小白";
    person.age = 22;
    [NSKeyedArchiver archiveRootObject:person toFile:path];
    
}


- (IBAction)readSavePerson:(id)sender
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/person.plist"];
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (person)
    {
        NSLog(@"名字是:%@",person.name);
        NSLog(@"年龄是:%ld",person.age);
    }
}

- (IBAction)createFmdbAction:(UIButton *)sender
{
    [FmdbTool shareManager];
}
- (IBAction)fmdbAddAction:(id)sender
{
    PersonInfoModel *model = [[PersonInfoModel alloc] init];
    model.userName = @"小白小灰";
    model.headImage = @"http://test.test.com";
    model.nickname = @"只缘感君一回顾";
    model.haveMoney = 22;
 
    [[FmdbTool shareManager] saveInfoWithPersonalModel:model];
}
- (IBAction)fmdbDeleteAction:(id)sender
{
    [[FmdbTool shareManager] deleteInfoWithUserName:@"小白小灰"];
}
- (IBAction)fmdbUpdateAction:(id)sender
{
    PersonInfoModel *model = [[PersonInfoModel alloc] init];
    model.userName = @"小白小灰";
    model.headImage = @"http://test.test.com";
    model.nickname = @"从此思君朝与暮";
    model.haveMoney = 22;
    [[FmdbTool shareManager] updateInfoWithPersonModel:model];
}
- (IBAction)fmdbSelectAction:(id)sender
{
  PersonInfoModel *model =  [[FmdbTool shareManager] selectInfoWithUserName:@"小白小灰"];
    NSLog(@"%@,%@,%@,%ld",model.userName,model.headImage,model.nickname,model.haveMoney);
}

- (IBAction)keyChainSaveAction:(id)sender
{
    if ( [SAMKeychain setPassword:@"白首如新，倾盖如故" forService:@"test" account:@"testAccount"])
    {
        NSLog(@"keyChin存储成功");
    }
    else
    {
        NSLog(@"keyChain存储失败");
    }
}

- (IBAction)keyChainReadAction:(id)sender
{
   NSString *passWord = [SAMKeychain passwordForService:@"test" account:@"testAccount"];
    NSLog(@"passWord is %@",passWord);
}

@end
