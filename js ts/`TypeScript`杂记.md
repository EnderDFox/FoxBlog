# 语法


###自定义Type
```TypeScript
type int = number
type int32 = number
type int64 = number
type uint = number
type uint32 = number
type uint64 = number
type char = string
```

## 基础类型


### 枚举

```TypeScript
enum DidField {
    VERSION = 0,    //版本
    ALL = -1,       //全部
    DESIGN = 1,     //策划
    ART = 2,        //美术
    CLIENT = 4,     //前端
    SERVER = 5,     //后端
    QA = 6,         //质检
    SUPERVISOR = 14, //监修
    TOOL = 16,       //工具
}
```

## 静态类型声明 

#### Function
```TypeScript
class ClassA{
    funcA(callback:(arg0:number,arg1:string)=>boolean): void
}
```


## d.ts

```TypeScript
declare class ProcessPanelClass {
    HideMenu(): void
}
declare var ProcessPanel: ProcessPanelClass
```

## 语法糖

### ?.

以前的写法
```TypeScript
var len = a==null?un:a.undefined:b;
```
现在可以简化为
```
var len = a?.b
```