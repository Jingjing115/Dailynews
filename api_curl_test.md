###注册
curl -X POST --data email=zhuguo@huantengsmart.com \
--data password=zhuguo1211 \
--data name=zhuguo \
localhost:3000/api/users/regist.json
###登陆
curl -X POST --data email=zhuguo@huantengsmart.com \
--data password=zhuguo1211 \
localhost:3000/api/users/login.json
###修改密码
curl -X PUT --data email=zhuguo@huantengsmart.com \
--data password=zhuguo \
--data new_password=zhuguo1211 \
localhost:3000/api/users/change_pwd.json
###发布一条blog
curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data title=test title \
--data content=test content \
localhost:3000/api/blogs.json
###获取所有blog
curl -X GET \
localhost:3000/api/blogs.json
###获取一条blog
curl -X GET --data id=1 \
localhost:3000/api/blogs/1.json
###评论一条blog
curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data id=1 \
--data content=test content \
localhost:3000/api/blogs/1/comments.json
###回复评论
curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data id=1 \
--data content=test rely \
localhost:3000/api/comments/1/relys.json
###获取所有daily
curl -X GET --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data release_date=2016-09-22 \
localhost:3000/api/dailies.json
###获取一条daily
curl -X GET --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
localhost:3000/api/dailies/1
###发布一条daily
curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data content=test content \
localhost:3000/api/dailies.json
###修改一条daily
curl -X PUT --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data content=test content \
localhost:3000/api/dailies.json
###获取所有用户组
curl -X GET --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
localhost:3000/api/user_groups
###获取某个用户组
curl -X GET --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
localhost:3000/api/user_groups/1
###创建一个用户组
curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--date name= \
--data description= \
localhost:3000/api/user_groups
###更新某个用户组
curl -X PUT --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--date name= \
--data description= \
localhost:3000/api/user_groups/1
###删除某个用户组
curl -X DELETE --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
localhost:3000/api/user_groups/1
###添加用户到用户组
curl -X PUT --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data user_id=2 \
localhost:3000/api/user_groups/1/users/2
###删除用户组中的用户
curl -X DELETE --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
localhost:3000/api/user_groups/1/users/2
###添加权限
curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data code=daily \
--data name=晨报权限 \
--data description=添加查看晨报 \
localhost:3000/api/permissions
