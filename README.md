# BaseKits
Quickly build project templates.

#### Important

R.generated.swift 是通过 R.swift 框架生成的，每次编译项目都会自动生成；一般情况来说，不用管他。

Localizable.strings 是语言文件，这个名字必须为 Localizable，否则框架内的语言切换不生效！

使用 IWViewModel 初始化视图时，需要重写 instanceController 变量，来达到初始化视图并绑定 ViewModel 的过程。


#### How to init Controller?

本框架采用 VM 驱动，初始化控制器通过在子类 VM（继承自 `IWViewModel` / `IWTableViewModel`） 中重写  `instanceController`，达到初始化控制器的过程。初始化完成则自动与 VM 进行绑定。

`instanceController` 仅用于初始化操作，并不提供 `get`、`set` 等读写操作。切记。 
