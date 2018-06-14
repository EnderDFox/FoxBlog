<!-- TOC -->

- [IDE](#ide)
    - [VSCode](#vscode)
        - [debug时的路径问题](#debug时的路径问题)
- [语法](#语法)
    - [Package](#package)
    - [切片](#切片)
        - [初始化](#初始化)
        - [len() 和 cap() 函数](#len-和-cap-函数)
        - [append elemnt](#append-elemnt)
        - [remove element at index](#remove-element-at-index)
        - [insert element at index](#insert-element-at-index)
        - [copy](#copy)
        - [make](#make)
    - [string](#string)
        - [to string](#to-string)
        - [join](#join)
    - [Image](#image)
        - [base64转图片](#base64转图片)
        - [[]bytes转Image](#bytes转image)
        - [Image转[]bytes](#image转bytes)
- [Debug](#debug)
    - [Error](#error)
        - [断点找不到go文件](#断点找不到go文件)

<!-- /TOC -->

# IDE

## VSCode

首先 GOPATH配置一个目录

用VSCode进入该目录,新建一个main.go文件,

写一个helloworld, VSCode会提示安装对应的包,全安装后,就可以debug了

为了方便最好配置  .code/launch.json

e.g.
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Go launch",
            "type": "go",
            "request": "launch",
            "mode": "debug",
            "remotePath": "../../",
            "port": 2345,
            "host": "127.0.0.1",
            // "program": "${fileDirname}",
            "program": "${workspaceFolder}/src/pm/main.go",
            "env": {
                "GOPATH":"D:/code/go/" 
            },
            "cwd": "${workspaceFolder}",//解决`debug时的路径问题`
            "args": [],
            "showLog": true
        }
    ]
}
```
### debug时的路径问题

main.go位于`src/pm/`

工作目录下有个`config.xml`

默认情况 go要访问这个xml, 需要用相对路径 `../../config.xml`

如果想用绝对路径 `./config.xml` 访问

需要在launch.json设置 `"cwd": "${workspaceFolder}",`

# 语法
## Package

包名一般为go代码所在的目录名，但是与java不同的是，go语言中包名只有一级

main是一个特殊的package名字，类似Java的main函数，GO的可执行程序必须在main package下，main包所在的文件夹一般都不叫main。

在同一个package里，多个文件被go编译器看作是一个文件一样，因此，这多个文件中不能出现相同的全局变量和函数，一个例外是init函数；而同一个package的不同文件可以直接引用相互之间的数据。

[图片上传失败...(image-c85d0f-1525777419011)]

## 切片

### 初始化
```Go
var ss []string;

slice := []int{10, 20, 30, 40, 50}

var slice1 []type = make([]type, len)

slice1 := make([]type, len)

s :=make([]int,len,cap)
```
也可以指定容量，其中capacity为可选参数。
```Go
make([]T, length, capacity)

s :=[] int {1,2,3 }

s := arr[:]

s := arr[startIndex:endIndex]

s := arr[:endIndex]

s1 := s[startIndex:endIndex]
```
### len() 和 cap() 函数

切片是可索引的，并且可以由 len() 方法获取长度。

切片提供了计算容量的方法 cap() 可以测量切片最长可以达到多少。

### append elemnt
```
ss=append(ss,fmt.Sprintf("s%d",i));
```

### remove element at index

```
index:=5;
ss=append(ss[:index],ss[index+1:]...)

```

### insert element at index

保存后部剩余元素，必须新建一个临时切片
```
rear:=append([]string{},ss[index:]...)
ss=append(ss[0:index],"inserted")
ss=append(ss,rear...)
```

### copy

```
var sa = make ([]string,0);
for i:=0;i<10;i++{
  sa=append(sa,fmt.Sprintf("%v",i))
}
var da =make([]string,0,10);
var cc=0;
cc= copy(da,sa);
```
### make

Slice : 第二个参数 size 指定了它的长度，此时它的容量和长度相同。

你可以传入第三个参数 来指定不同的容量值，但是必须不能比长度值小。

比如: make([]int, 0, 10)

Map: 根据size 大小来初始化分配内存，不过分配后的 map 长度为0。 如果 size 被忽略了，那么会在初始化分配内存的时候 分配一个小尺寸的内存。

Channel: 管道缓冲区依据缓冲区容量被初始化。如果容量为 0 或者被 忽略，管道是没有缓冲区的。

## string

### to string
```
fid uint64
fidStr := strconv.FormatUint(fid, 10) //string(fid)的结果是乱码,不能用
```

### join

```
var arr = [...]uint64{3, 4, 5}
var strArr []string
for _, item := range arr {
    strArr = append(strArr, strconv.FormatUint(item, 10))
}
// s = {3,4,5,6}
rs := strings.Join(strArr, ",")
```
## Image

type image.Image

### base64转图片
```Go
ddd, err_decode := base64.StdEncoding.DecodeString(param.Data)
if err_decode != nil {
    log.Println("err_decode:", err_decode)
    return false
}
log.Println("decode success", time.Now().Unix())
```

### []bytes转Image
```
original_image, _, err := image.Decode(bytes.NewReader(param.Data))
```
### Image转[]bytes

**未测试** 

参考 <https://stackoverflow.com/questions/22945486/golang-converting-image-image-to-byte>

```
buf := new(bytes.Buffer)

err := jpeg.Encode(buf, new_image, nil)

send_s3 := buf.Bytes()
```


# Debug

## Error

### 断点找不到go文件

![img][img1]

[img1]:data:image/png;base64,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

解决方法:

```cmd
cd C:\Go\src
mklink /j pm D:\AmazingGame\tool_svn\src\pm
````