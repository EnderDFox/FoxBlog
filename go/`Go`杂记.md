<!-- TOC -->

- [IDE](#ide)
    - [VSCode](#vscode)
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

<!-- /TOC -->

# IDE

## VSCode

首先 GOPATH配置一个目录

用VSCode进入该目录,新建一个main.go文件,

写一个helloworld, VSCode会提示安装对应的包,全安装后,就可以debug了

为了方便最好配置  .code/launch.json

e.g.
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Go launch",
            "type": "go",
            "request": "launch",
            "mode": "debug",
            "remotePath": "",
            "port": 2345,
            "host": "127.0.0.1",
            "program": "${workspaceFolder}",
            "env": {},
            "args": [],
            "showLog": true
        }
    ]
}
```
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