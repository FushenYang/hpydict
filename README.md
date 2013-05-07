# HpyDict

最近在学习英语，在查字典的时候经常要翻阅好几个的词典网站，为了方便自己，主要是为了整合 [Merriam-Webster](http://www.merriam-webster.com) 的音标和真人发音。

有需要的可以`clone`下来自己用，也可以`fork`一下添加自己需要的功能。

`player.rb`
可以直接在命令行下进行使用，提供下载与朗读单词的功能，具体请参考
`vowels_exp.rb`。

# 安装

* Ruby 1.9.3@p392
* Rvm
* Pow (optional)

```bash
git clone git://github.com/hpyhacking/hpydict.git
cd hpydict
bundle
mv initializers/merriam_webster.sample initializers/merriam_webster.rb
# add your merria-webster api_key
# start any rack server and visit
```

# 说明

使用前需要去 [Merria-webster](http://www.dictionaryapi.com) 注册一个开发者帐号，并配置自己的`api_key`。

每开发者帐号限制日访问量 2,000 次，足够日常使用了。
