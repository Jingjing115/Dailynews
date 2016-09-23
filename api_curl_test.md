curl -X POST --data email=zhuguo@huantengsmart.com \
--data password=zhuguo1211 \
--data name=zhuguo \
localhost:3000/api/users/regist.json

curl -X POST --data email=zhuguo@huantengsmart.com \
--data password=zhuguo1211 \
localhost:3000/api/users/login.json

curl -X PUT --data email=zhuguo@huantengsmart.com \
--data password=zhuguo \
--data new_password=zhuguo1211 \
localhost:3000/api/users/change_pwd.json

curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data title=test title \
--data content=test content \
localhost:3000/api/blogs.json

curl -X GET \
localhost:3000/api/blogs.json

curl -X GET --data id=1 \
localhost:3000/api/blogs/1.json

curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data id=1 \
--data content=test content \
localhost:3000/api/blogs/1/comments.json

curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data id=1 \
--data content=test rely \
localhost:3000/api/comments/1/relys.json

curl -X GET --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data release_date=2016-09-22 \
localhost:3000/api/dailies.json

curl -X GET --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
localhost:3000/api/dailies/1

curl -X POST --header "Authorization: a1132f22df11e0e1047b55c338d6e8c0" \
--data content=test content \
localhost:3000/api/dailies.json
