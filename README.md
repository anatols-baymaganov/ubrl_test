# ubrl_test

#### Development setup:

    cp config/database.yml.example config/database.yml
    bundle install
    bundle exec rails db:create
    bundle exec rails db:migrate
    bundle exec rails db:seed
    bundle exec rails s

#### Request examples:

* Add new post:

        curl -v -XPOST "http://localhost:3000/api/v1/posts?login=umbrellio&title=title&text=text"

* Get top N posts by avg_score:

        curl -v -XGET "http://localhost:3000/api/v1/posts/top?count=5"

* Add new score to existed post:

        curl -v -XPOST "http://localhost:3000/api/v1/scores?post_id=1&value=5"

* Get ips for list of users' logins:

        curl -v -XGET "http://localhost:3000/api/v1/users/author_ips?logins[]=umbrellio&logins[]=admin"
