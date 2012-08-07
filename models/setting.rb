class Setting < Sequel::Model
  
  set_schema do
    primary_key :id
    varchar :name
    varchar :title
    varchar :code
    varchar :feed
    varchar :footer
    varchar :tracker
  end
  
  unless table_exists?
    create_table
    create(
      :name => 'Railsstep',
      :title => "It's a small step for a man, a big step for hummanity",
      :code => 'matrix1989'
    )
  end
  
  sync
  
  def self.from_database
    filter.first
  end
  
end