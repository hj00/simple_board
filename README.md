# 2017.11.13 6일차

```ruby
# #{}형식으로 변수를 담을 시에는 ""써야 함.
```

# Simple Board

1. User, Post

2. Model

   ```ruby
   rails g model post title:string content:string
   ```

   - User Model
     - string, email
     - string, password
   - Post Model
     - string, title
     - string, content

3. Controller

   - user controller

     - user#index : 모든 유저들을 보여준다.
     - user#new : 새로운 유저를 생성하는 form을 보여준다.(회원가입)
     - user#create : new에서 작성한 회원 정보를 DB에 저장한다.
     - user#show : /user/show:id 해당하는 유저 한명한 보여준다.
     - user#login : form에 로그인이 가능한 페이지를 보여준다.
     - user#login_process : 로그인 정보와 DB유저 정보를 비교해 user를 로그인 시킨다.

   - post controller

     - post#index : 모든 게시글을 보여준다.

     - post#new : 새로운 게시글을 만드는 form을 보여준다.

     - post#create : new에서 작성한 글을 쓴다 == DB에 저장한다.

       ```ruby
       Post.create(
       	title: @title,
         	content: @content
       )
       ```

     - post#show : /post/show:id 해당하는 글 1개만 보여준다.

     - post#modify : 게시글을 수정할 수 있는 form을 보여준다.

     - post#update : modify에서 수정된 글을 DB에 새로 저장한다.(update 한다.)

       - n번 글에 대해서 수정

         -> n번 글을 찾는다.

         ```ruby
         post = Post.find(params[:id])
         ```

         -> 해당 글을 업데이트 한다.

         ```ruby
         post.update(title: params[:title], content: params[:content])
         ```

     - post#destroy : show에서 확인한 글을 지울 수 있게 한다.

       - n번 글을 찾는다.

         ```ruby
         @id = params[:id]
         post = Post.find(@id)
         ```

       - 해당 글을 삭제

         ```ruby
         post.destroy
         ```

   ### User & Post

   - 1:N : User & Post / Post & Reply

     ex) Class(1) & Student(N), Major(1) & Student(N) -> Major(M) & Student(N)

     - 1 User가 여러 Post를 가질 수 있다.
     - Post들은 특정 한 User 속해야한다.

   - Post를 작성한 글쓴이에 대한 정보 탐색 및 회원이 작성한 Post들에 대한 정보 탐색

     ```ruby
     post = Post.find(3)
     userid = post.user_id
     user = User.find(userid)
     user.email

     ↓↓↓

     post = Post.find(3)
     user = User.find(4)
     post.user.email
     user.posts
     User.find(4).posts[1].title
     User.find(4).posts.last.content
     ```

   - dummy data 만들기

     ```ruby
     gem install faker

     require 'faker'
     Faker::Name.name