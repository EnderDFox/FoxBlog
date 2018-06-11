
# KeyboardEvent

共有三个
- keydown
- keypress
- keyup

## 特性

- `keydown` 和 `keypress` 在按键按下时,每帧都会抛出事件(opera浏览器除外)
- `keydown` 返回键盘的代码 可以侦听非字符按键
- `keypress` 返回的是ASCII字符 仅侦听 **字符** 不会侦听 **ctrl** **shift** **ctrl** 等非字符按键