# Code Test API

## Prompt

Create a simple RESTful API in Ruby using Rails and ActiveRecord. Use PostgreSQL as a local database.  Implement two models with a one to many parent­-child relationship.  API should accept POST requests (Content­Typeapplication/json) to create  objects and persist them to a database.   Additionally, implement GET endpoints for each model (accessed by primary key) such  that associated objects are returned  e.g. requests on parent objects should nest children as a JSON array.  For example:

```javascript
{ "name" : "Parent",
  "id" : 1,
  "children" : [
    {
      "id" : 1,
      "name" : "Child One"
    },
    {
      "id" : 2,
      "name" : "Child Two"
    }
  ]
} 
```

requests on a child object should also include a parent element.

```javascript
{ "name" : "Child One",
  "id" : 1,
  "parent" : {
    "id" : 1,
    "name" : "Parent"
  }
}
```


## Planning

![one-to-many](/planning/IMG1_one-to-many.jpg)

Two models with a one to many relationship.

![relationship](/planning/IMG2_relationship.jpg)

Class Relationships

![dbtables](/planning/IMG3_tables.jpg)

Parents and Children Tables


## To get the API up and running

* Ruby (2.2.3p173)
* Rails (4.2.4)
* Rake (10.5.0, 10.4.2)


## Steps I followed

```ruby
$ rails new code_test_api -T --database=postgresql
```

ran into brew/pg error, used brew doctor to link psql and get gem installed

```ruby
$ rake db:create
$ rails g migration CreateParents
      invoke  active_record
      create    db/migrate/20160302020255_create_parents.rb
```

added t.string :name

```ruby
$ rake db:migrate
      20160302020255 CreateParents: migrating
      create_table(:parents)
$ rails g migration CreateChildren
      invoke  active_record
      create    db/migrate/20160302023118_create_children.rb
```

added t.string :name and t.integer :parent_id

```ruby
$ rake db:migrate
      20160302023118 CreateChildren: migrating
      create_table(:children)
```

created app/models/parent.rb and app/models/child.rb

used irb to insert models into db

```ruby
p = Parent.new
p.name = "Leia"
p.save
   (0.3ms)  BEGIN
  SQL (0.6ms)  INSERT INTO "parents" ("name") VALUES ($1) RETURNING "id"  [["name", "Leia"]]
   (1.2ms)  COMMIT
=> true

c = Child.new
c.name = "Jaina"
c.parent_id = 1
c.save
   (0.2ms)  BEGIN
  SQL (0.7ms)  INSERT INTO "children" ("parent_id", "name") VALUES ($1, $2) RETURNING "id"  [["parent_id", 1], ["name", "Jaina"]]
   (1.3ms)  COMMIT
=> true

j = Child.new
j.name = "Jacen"
j.parent_id = 1
j.save
   (0.2ms)  BEGIN
  SQL (0.3ms)  INSERT INTO "children" ("name", "parent_id") VALUES ($1, $2) RETURNING "id"  [["name", "Jacen"], ["parent_id", 1]]
   (1.3ms)  COMMIT
=> true
```

created app/controllers/parents_controller.rb and app/controllers/children_controller.rb

added routes

added gem 'rack-cors', :require => 'rack/cors' to gemfile, bundle install
