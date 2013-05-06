# HpyDict

最近在学习英语，在查字典的时候经常要翻阅好几个的词典网站，于是就有了HpyDict这个项目。主要是为了整合 Merriam-Webster 的音标和真人发音。

目前已经整合了 Merriam-Webster 的音标和真人发音，下一步要引入中文解释，还有例句等等。

然后我会放到Github上，大家如果有需要的可以clone下来自己用，也可以fork一下添加自己需要的

# 安装

* Ruby 1.9.3@p392
* Rvm
* Pow (optional)

```bash
git clone git://github.com/hpyhacking/hpydict.git
cd hpydict
mv initializers/merriam_webster.sample initializers/merriam_webster.rb
# add your merria-webster api_key

# start any rack server and visit
```

# 说明

使用前需要去merria-webster注册一个开发者帐号，并配置自己的`api_key`。

每开发者帐号可以日访问2000次，足够日常使用了。
