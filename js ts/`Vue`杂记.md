
# 教程

## 基础

### 计算属性和侦听器

#### 计算属性

```HTML
<div id="example">
  <p>Original message: "{{ message }}"</p>
  <p>Computed reversed message: "{{ reversedMessage }}"</p>
</div>
```

```JavaScript
var vm = new Vue({
  el: '#example',
  data: {
    message: 'Hello'
  },
  computed: {
    // 计算属性的 getter
    reversedMessage: function () {
      // `this` 指向 vm 实例
      return this.message.split('').reverse().join('')
    }
  }
})
```

#### 侦听属性

```HTML
<div id="demo">{{ fullName }}</div>
```

```JavaScript
var vm = new Vue({
  el: '#demo',
  data: {
    firstName: 'Foo',
    lastName: 'Bar',
    fullName: 'Foo Bar'
  },
  watch: {
    firstName: function (val) {
      this.fullName = val + ' ' + this.lastName
    },
    lastName: function (val) {
      this.fullName = this.firstName + ' ' + val
    }
  }
})
```


#### 计算属性的 setter

计算属性默认只有 getter ，不过在需要时你也可以提供一个 setter ：

```TypeScript
// ...
computed: {
  fullName: {
    // getter
    get: function () {
      return this.firstName + ' ' + this.lastName
    },
    // setter
    set: function (newValue) {
      var names = newValue.split(' ')
      this.firstName = names[0]
      this.lastName = names[names.length - 1]
    }
  }
}
```

#### 侦听器

<!-- TODO -->

现在再运行 vm.fullName = 'John Doe' 时，setter 会被调用，vm.firstName 和 vm.lastName 也会相应地被更新。


### 表单输入绑定

#### 修饰符

##### .lazy

在默认情况下，v-model 在每次 input 事件触发后将输入框的值与数据进行同步 (除了上述输入法组合文字时)。你可以添加 lazy 修饰符，从而转变为使用 change 事件进行同步：

```TypeScript
<!-- 在“change”时而非“input”时更新 -->
<input v-model.lazy="msg" >
```

##### number

如果想自动将用户的输入值转为数值类型，可以给 v-model 添加 number 修饰符：

```TypeScript
<input v-model.number="age" type="number">
```

##### trim

如果要自动过滤用户输入的首尾空白字符，可以给 v-model 添加 trim 修饰符：

```TypeScript
<input v-model.trim="msg">
```

### v-model

#### checkbox

> 规则1：如果v-model绑定的变量类型为boolean，若input被选中，this.inputdata为true,否则this.inputdata为false。

> 更新inputdata为true，那么渲染结束之后三个input均为选中状态，且三个input状态同步

```TypeScript
<input type="checkbox" v-model="inputdata" checked/>
<input type="checkbox" v-model="inputdata"/>
<input type="checkbox" v-model="inputdata"/>
new Vue({
    el:".......",
    data:{
        inputdata:false  //逻辑类型
    }
　　ready:function(){
　　　　console.log(this.inputdata)//true
　　}
})
```

> 规则2：如果v-model绑定的变量类型为数组，那么绑定该变量的元素若被选中，把该元素的value值添加进数组，若不被选中，那么把该元素的value从数组中去除。

```TypeScript
<input type="checkbox" value="a" v-model="inputdata" checked/>
<input type="checkbox" value="b" v-model="inputdata"/>
<input type="checkbox" value="c" v-model=""inputdata" checked/>
new Vue({ 
　　el:".......", 
　　data:{ 
　　　　inputdata:[]//数组类型
　　} 　　
　　ready:function(){ 　　　　
　　　　console.log(this.inputdata)//[a,c]
　　} 
})
```

#### radio

> 规则：v-model绑定的变量值如果等于input元素其中一个value值，那么该表单元素会被选中，如果不等于任何input的value值，所有相关元素不选中。同时如果选中某个input元素，那么该元素的value值就会被赋给该变量，页面重新渲染。

```TypeScript
<input type="radio" value="a" v-model="inputdata" />
<input type="radio" value="b" v-model="inputdata" checked/>
<input type="radio" value="c" v-model="inputdata" checked/>

new Vue({
    el:".......",
    data:{
        inputdata:"a"
    }
　　ready:function(){
　　　　console.log(this.inputdata)//  c
　　}
})
```

#### select

> 规则：v-model绑定的变量值如果等于option元素其中一个value值，那么该元素会被选中。同时如果选中某个option元素，那么该元素的value值就会被赋给该变量。

```TypeScript
<select v-model="selected">
  <option>A</option>
  <option selected>B</option>
  <option>C</option>
</select>
<br>
<span>Selected: {{ selected | json }}</span>

new Vue({
　　el:"....",
　　data:{
　　　　selelcted:"A"
　　}
})
```

#### lazy

> 在默认情况下，v-model 在input 事件中同步输入框值与数据，可以添加一个特性lazy，input值发生改变时，不会同步到绑定的变量

```TypeScript
<input type="text" v-model="msg" lazy>//input值发生改变，msg不变
```

#### number

> 如果想自动将用户的输入转为 Number 类型（如果原值的转换结果为 NaN 则返回原值），可以添加一个特性 number：

```TypeScript
<input v-model="age" number> //默认输入框内的值为字符串，添加number，可以将输入值转换为数字在同步到age
```

#### debounce

> 设置一个最小的延时，在每次敲击之后延时同步输入框的值与数据。如果每次更新都要进行高耗操作（例如在输入提示中 Ajax 请求），它较为有用.

```TypeScript
<input v-model="msg" debounce="500">//输入内容0.5秒后同步到msg

vm.$watch({
　　'msg':function(val,oldval){
　　　　　　
　　}
})
```

> 注意 debounce 参数不会延迟 input 事件：它延迟“写入”底层数据(所以不适合ajax请求事件)。因此在使用debounce 时应当用 vm.$watch() 响应数据的变化。

若想延迟 DOM 事件，应当使用debounce过滤器。 

#### debounce过滤器

> 包装处理器，让它延迟执行 x ms， 默认延迟 300ms。包装后的处理器在调用之后至少将延迟 x ms， 如果在延迟结束前再次调用，延迟时长重置为 x ms。

> *用此过滤器非常适合做`ajax请求`*

```TypeScript
<input @keyup="onKeyup | debounce 500">//只要操作键盘间隔小于0.5秒，就不会发生onKeyup事件。
```

## 其他

### 过滤器

[e.g.](https://jsfiddle.net/chrisvfritz/6744xnjk/?utm_source=website&utm_medium=embed&utm_campaign=6744xnjk)

```HTML
div id="app">
  <div>
    <label>Price</label>
    <input v-model="price | currency">
  </div>
  ...
```

```TypeScript
Vue.filter('currency', {
  read: function (value) {
    return '$' + value.toFixed(2)
  },
  write: function (value) {
    var number = +value.replace(/[^\d.]/g, '')
    return isNaN(number) ? 0 : number
  }
})

new Vue({
  el: '#app',
  data: {
    price: 0,
    shipping: 0,
  ...
  
```