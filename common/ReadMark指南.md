# 标题

```markdown
# 一级标题 
## 二级标题 
### 三级标题 
#### 四级标题 
##### 五级标题 
###### 六级标题
```

等号及减号也可以进行标题的书写，不过只能书写二级标题，并且需要写在文字的下面，减号及等号的数量不会影响标题的基数，如下：

二级标题 
=========

二级标题 
---------


# 列表

- 无序列表1 
- 无序列表2 
  - 无序列表2.1 
     - 列表内容 
     - 列表内容


1. 有序列表1 
2. 有序列表2 
3. 有序列表3 

# 引用

>这个是引用 

> 是不是和电子邮件中的 
> 
> 引用格式很像

# 粗体和斜体

**这个是粗体** 

*这个是斜体* 

***这个是粗体加斜体***

# 链接

## 标准用法

[link text](http://example.com/ "optional title")

[link text no title](http://example.com/)

## 引用方式
在引用中加链接，第一个中括号添加需要添加的文字，第二个中括号中是引用链接的id，之后在引用中，使用id加链接：如下：

**`[id]`上方的一定要有空行**

[link text][id] 

[id]: http://example.com/ "optional title here"

## 尖括号直接引用链接

<http://example.com/> or <address@example.com> 


# 图片

## 标准用法

![这里写图片描述](https://avatars1.githubusercontent.com/u/30207834?s=40&v=4)

## 引用方式

![这里写图片描述][jane-eyre-douban] 

[jane-eyre-douban]: https://avatars1.githubusercontent.com/u/30207834?s=40&v=4

## base64

![img][i1]

[i1]: data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAANCAYAAABGkiVgAAACLUlEQVQ4EX2Tz2sTQRiGn9mZ/ZFmk02ItlFp1bTWVg1thVKKil4Ee5DqSZCiJxG8iyAUBW+K+BcIgnjo3bsUpeKtIAgVwaaFWiwkGpuSmN2O7KYpsSxd+JhvZ/d75p33mxFdhR7N3kcYkD9H7tYLpNeD1rAdRuDTWP1K7f0rtksfMPwyIqgDAi272FYZZP8Uai8vfNcySWr8OraXQxstIBoaq0vU3j6BjUVkUPuvVPhVpF9FL83FQ0Uyj9N7GmmqSKXQEEZt/mUEFHuAnXTh/8bonGjnRqYPJ5NDCpBGK+rfPuEvf2Q/YKtexys1kgdxvDRC0vIT2Fp8h9Est9fdd4z1VCqbhG0S7iNsUtjJ5sYKImjsC2t/jIUaQpOQOlIqdv6Ulo0vBOj2TBvRORpo6cRvX9S3cIIGdsIkRITe5nqPs/49gfA3Oym7uVYpvO5BZqavxkN1fQPz7yauciOgacCpyQusLcwhY6DasDgxfJ7Xz2YZ7DsS3/1GpURQWSdlgmdB1oLR0TH6xy+D8qLDHkkUKjrT6VyBp/fvURw4imNb8UqDzZ+sf15gqDhM0rRxJFHcuH2HN39+sfplHppVjg1OMnNtmpGT/UyODiFCz9FIM+s+3jVmJxE6oFKuUZy4RHc2TdIUuEqQz7hMnB1jZa1KvSl5PvuQm1MXOTPQi21Z7WpE7N0P11NpDhWvcPfBI7qzHl0KXAVpE1IKfpSWGSkc5oBrYYadjFSGXME/Xf2hMPRq4CEAAAAASUVORK5CYII=


# 代码块

用TAB键起始的段落，会被认为是代码块，如下：
    <php> 
        echo “hello world"; 
    </php>

如果在一个行内需要引用代码，只要用反引号`引起来就好，如下：

Use the `printf()` function.

# 代码块与语法高亮

在需要高亮的代码块的前一行及后一行使用三个反引号“`”，同时第一行反引号后面表面代码块所使用的语言，如下：
```ruby 
require 'redcarpet' 
markdown = Redcarpet.new("Hello World!") 
puts markdown.to_html 
```

# 分割线

可以在一行中用三个以上的星号、减号、底线来建立一个分隔线，同时需要在分隔线的上面空一行。如下：

--- 

**** 

___

删除线的使用，在需要删除的文字前后各使用两个符合“~”，如下

~~Mistaken text.~~


# 表格

可以使用冒号来定义表格的对齐方式，如下：
| Tables | Are | Cool | 
| ------------- |:-------------:| -----:| 
| col 3 is | right-aligned | $1600 | 
| col 2 is | centered | $12 | 
| zebra stripes | are neat | $1 | 


# 数学公式

使用MathJax渲染*LaTex* 数学公式，详见[ math.stackexchange.com]
行内公式，数学公式为：
$\Gamma(n) = (n-1)!\quad\forall n\in\mathbb N$ 
块级公式：
$$ x = \dfrac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

更多LaTex语法请参考 [ 这儿]。

