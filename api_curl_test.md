###注册
curl -X POST --data email=zg@huantengsmart.com \
--data password=zhuguo1211 \
--data name=zhuguo \
localhost:3000/api/user/regist.json
###登陆
curl -X POST --data email=zg@huantengsmart.com \
--data password=zhuguo1211 \
localhost:3000/api/user/login.json
###修改密码
curl -X PUT --data email=zhuguo@huantengsmart.com \
--data password=zhuguo \
--data new_password=zhuguo1211 \
localhost:3000/api/user/change_pwd.json
###发布一条blog
curl -X POST --header "Authorization: 329049759f37016bb04586a8d3a61d0f" \
--data title=test title \
--data content=test content \
localhost:3000/api/blogs.json
###获取所有blog
curl -X GET \
--data per_page=30 \
localhost:3000/api/blogs.json
###获取一条blog
curl -X GET --data id=1 \
localhost:3000/api/blogs/1.json
###评论一条blog
curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data content=test content \
localhost:3000/api/blogs/2/comments.json
###回复评论
curl -X POST --header "Authorization: 329049759f37016bb04586a8d3a61d0f" \
--data content=test reply \
localhost:3000/api/comments/3/replys.json
###获取所有daily
curl -X GET --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data release_date=2016-09-22 \
localhost:3000/api/dailies.json
###获取一条daily
curl -X GET --header "Authorization: 329049759f37016bb04586a8d3a61d0f" \
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
curl -X GET --header "Authorization: 329049759f37016bb04586a8d3a61d0f" \
localhost:3000/api/user_groups
###获取某个用户组
curl -X GET --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
localhost:3000/api/user_groups/1
###创建一个用户组
curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data name=幻腾用户组 \
--data description=幻腾用户组（晨报权限） \
localhost:3000/api/user_groups
###更新某个用户组
curl -X PUT --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data name= \
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
###添加权限到用户组
curl -X PUT --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data permission_id=2 \
localhost:3000/api/user_groups/1/permissions/2
