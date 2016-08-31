curl -X POST --data email=zhuguo@huantengsmart.com \
--data password=zhuguo1211 \
--data name=zg \
localhost:3000/api/users/regist.json

curl -X POST --data email=zhuguo@huantengsmart.com \
--data password=zhuguo1211 \
localhost:3000/api/users/login.json

curl -X POST --data email=zhuguo@huantengsmart.com \
--data password=zhuguo1211 \
--data new_password=zhuguo \
localhost:3000/api/users/change_pwd.json

curl -X POST --header "Authorization: ae31f39fe1229f3ffbe773b98b59ceb1" \
--data title=test title \
--data content=test content \
localhost:3000/api/blogs.json

curl -X GET \
localhost:3000/api/blogs.json

curl -X GET --data id=1 \
localhost:3000/api/blogs/1.json

curl -X POST --header "Authorization: ae31f39fe1229f3ffbe773b98b59ceb1" \
--data id=1 \
--data content=test content \
localhost:3000/api/blogs/1/comments.json
