# 20180625_Day11

### 오전과제

- Rails의 form_for에 대해 살펴보기



### model_params

- 지난주에 액션에서 공통되는 코드들을 묶어 메소드로 활용하는 방법을 배웠다. 지금 컨트롤러에서는 반복되는 코드가 한가지 더 있는데 바로 `create` 와 `update`에서 컬럼에 내용물을 채워주는 코드이다.

*app/controllers/post_controller.rb*

```ruby
def create
    post = Post.new
    post.title = params[:title]
    post.contents = params[:contents]
    post.save
    redirect_to "/post/#{post.id}"
end
```

- 위 코드는 `update` 액션에도 있는데 위 코드를 묶어 crud 코드 작성 시 파라미터들을 묶어주는 코드로 활용할 수 있다.

```ruby
def create
    post = Post.new(title: params[:title], contents: params[:contents])
    post.save
    redirect_to "/post/#{post.id}"
end
```

- 위와같은 형태로 파라미터들을 묶어서 한줄로 사용할 수 있다. 하지만 여전히 `create`와 `update`에 중복된 코드들이 남아있다. 이부분을 메소드로 묶어서 사용할 수 있다. 루비에서 메소드의 리턴값은 해당 메서드에서 가장 마지막에 호출된 값이 된다.

```ruby
def post_params
	{title: params[:title], contents: params[:contents]} 
end
```

- 해쉬 형식으로 파라미터들을 묶어서 사용할 수 있다. 이제 `create`와 `update`에서 코드를 다음과 같이 사용할 수 있다.

```ruby
def create
    post.new(post_params)
    post.save
    redirect_to "/post/#{post.id}"
end

def update
    post.update(post_params)
    # .update 메서드는 내용물을 수정 후 .save 메서드 실행까지를 대신한다.
    redirect_to "/post/#{post.id}"
end
```



### render

- 그동안 controller에서 여러 반복되는 코드들을 메소드로 묶고 호출해서 사용하는 방식을 배웠다. 이와 같은 맥락으로 view에서도 반복되는 코드들을 묶어 매우 긴 view의 코드들을 분해하고 필요한 부분마다 분해해서 사용하는 방식이 있다. 먼저 코드를 분해하는 방법은 다음과 같다.

> 파일명 앞에 _(under score)를 붙여야 분해해서 사용할 수 있다.
>
> 사용할 때에는 <%= render '_를 제외한 파일명' %> 의 형식으로 사용한다.

*app/views/board/_ranking.html.erb*

```html
<h1>검색어랭킹</h1>
<p>1. 멀티캠퍼스</p>
<p>2. 멋쟁이 사자처럼</p>
<p>3. 4차 산업</p>
<p>4. NCS</p>
<p>5. 코드네임</p>
```

*app/views/board/index.html.erb*

```erb
...
<%= render 'ranking' %>
...
```



- `render`를 이용하기 위한 파일에서 지역변수를 사용할 경우 다음과 같은 방법으로 변수를 전달할 수 있다.

```erb
<%= render 'ranking', post: @post %>
```

- 위 방법을 활용하여 각기 다른 액션에서 설정한 다른 이름의 인스턴스 변수를 지역변수로 활용할 수 있다.



### scaffold

- 지금까지 우리는 CRUD 코드를 최대한 RESTful 하게, 그리고 메소드나 렌더링을 활용하여 반복되는 코드를 최소한으로 줄여왔다. 이 모든 것들은 레일즈의 강력한 기능인 `scaffold`를 활용하고 이해하기 위함이였다. 우리가 했던 모든 것들을 하나의 명령으로 만들어 낼 수 있다.

```command
$ rails g scaffold theme title:string description:text
Running via Spring preloader in process 3583
      invoke  active_record
      create    db/migrate/20180625052020_create_themes.rb
      create    app/models/theme.rb
      invoke    test_unit
      create      test/models/theme_test.rb
      create      test/fixtures/themes.yml
      invoke  resource_route
       route    resources :themes
      invoke  scaffold_controller
      create    app/controllers/themes_controller.rb
      invoke    erb
      create      app/views/themes
      create      app/views/themes/index.html.erb
      create      app/views/themes/edit.html.erb
      create      app/views/themes/show.html.erb
      create      app/views/themes/new.html.erb
      create      app/views/themes/_form.html.erb
      invoke    test_unit
      create      test/controllers/themes_controller_test.rb
      invoke    helper
      create      app/helpers/themes_helper.rb
      invoke      test_unit
      invoke    jbuilder
      create      app/views/themes/index.json.jbuilder
      create      app/views/themes/show.json.jbuilder
      create      app/views/themes/_theme.json.jbuilder
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/themes.coffee
      invoke    scss
      create      app/assets/stylesheets/themes.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.scss
```

- 명령어를 통해 만들어진 파일들의 내용을 확인하고 우리가 작성했던 코드들과 비교해보자.



### 간단과제

```command
$ rails _5.0.6_ new crud_test
```

- scaffold 명령을 사용하지 않고 CRUD코드 완성하기
- 모델: 단수(*post.rb*), 컨트롤러: 복수(*posts_controller.rb*)
- 모델명, 컨트롤러명 아무거나 원하는 데로. but 일치시키기