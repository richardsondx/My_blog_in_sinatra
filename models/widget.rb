class Widget < Sequel::Model
  
  # set_schema do
  #   primary_key :id
  #   varchar :title
  #   varchar :content
  #   integer :order
  #   boolean :admin
  # end

  unless table_exists? 
    DB.create_table :widgets do
      primary_key :id
      String :title
      String :content
      integer :order
      boolean :admin
    end
  end
  
  unless self.count > 0
    create(
      :title => 'Subscribe',
      :content => '<ul id="feed"><li><a href="/feed">Feed</a></li></ul>',
      :order => 10
    )
  end
  
end