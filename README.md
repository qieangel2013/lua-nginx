###lua-nginx
lua-nginx
###use
   access_count.lua(分流)
   access_limit.lua（防刷）
   config.json（配置） 
   config.lua（初始化文件）
   counter.lua（计数器）
###nginx
  lua_shared_dict config 1m;
  lua_package_path "/usr/share/lua/5.1/?.lua;/usr/lib64/lua/5.1/?.lua;;";
  lua_package_cpath '/usr/share/lua/5.1/?.so;/usr/lib64/lua/5.1/?.so;;';
  init_by_lua_file /usr/local/nginx/lua/config.lua;
   location / {
		content_by_lua_file /usr/local/nginx/lua/counter.lua ;
		#content_by_lua_file /usr/local/nginx/lua/access_limit.lua ;
		#content_by_lua_file /usr/local/nginx/lua/access_count.lua ;
	}

