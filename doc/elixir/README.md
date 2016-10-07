Elixir lang
-----

### install 

mac 

brew install elixir


elixir -v

### 教程

https://github.com/elixir-lang-china/elixir_guide_cn/

https://github.com/elixir-lang-china/elixir_style_guide

https://github.com/elixir-lang-china/etudes-for-elixir  企业级应用

http://fredwu.me/post/147855522498/i-accidentally-some-machine-learning-my-story-of 学习路径,不错

### tools

https://github.com/tonini/alchemist.el

https://github.com/slashmili/alchemist.vim/wiki

emacs 

### phoenix

http://www.phoenixframework.org

#### install 

  http://www.phoenixframework.org/docs/installation
  
  mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
  
  Plug, Cowboy, and Ecto
  
  
#### quick start
  
  pg
  
  mix phoenix.new hello_phoenix

  We are all set! Run your Phoenix application:

      $ cd hello_phoenix
      $ mix phoenix.server

  You can also run your app inside IEx (Interactive Elixir) as:

      $ iex -S mix phoenix.server

  Before moving on, configure your database in config/dev.exs and run:

      $ mix ecto.create
      
  http://www.phoenixframework.org/docs/using-mysql
  
  mix phoenix.new hello_phoenix --database mysql
  
  
  mix ecto.create # db create
  mix ecto.migrate
  
  mix phoenix.server
  
  
  

  
  



