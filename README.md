#lua-nginx
lua-nginx
###use
   access_count.lua(分流)<br/>
   access_limit.lua（防刷）<br/>
   config.json（配置） <br/>
   config.lua（初始化文件）<br/>
   counter.lua（计数器）<br/>
###nginx
  lua_shared_dict config 1m;<br/>
  lua_package_path "/usr/share/lua/5.1/?.lua;/usr/lib64/lua/5.1/?.lua;;";<br/>
  lua_package_cpath '/usr/share/lua/5.1/?.so;/usr/lib64/lua/5.1/?.so;;';<br/>
  init_by_lua_file /usr/local/nginx/lua/config.lua;<br/>
   location / {<br/>
		content_by_lua_file /usr/local/nginx/lua/counter.lua ;<br/>
		#content_by_lua_file /usr/local/nginx/lua/access_limit.lua ;<br/>
		#content_by_lua_file /usr/local/nginx/lua/access_count.lua ;<br/>
	}
###交流使用
	交流群：337937322
###如果你对我的辛勤劳动给予肯定，请给我捐赠，你的捐赠是我最大的动力
![](https://github.com/qieangel2013/zys/blob/master/public/images/pay.png)
[项目捐赠列表](https://github.com/qieangel2013/zys/wiki/%E9%A1%B9%E7%9B%AE%E6%8D%90%E8%B5%A0)
