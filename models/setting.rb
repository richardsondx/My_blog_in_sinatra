class Setting < Sequel::Model
  
  set_schema do
    primary_key :id
    String :name
    String :title
    String :code
    String :feed
    String :footer
    String :tracker
  end
  
  unless table_exists?
    create_table
    create(
      :name => 'Railsstep',
      :title => "It's a small step for a man, a big step for hummanity",
      :code => 'admin'
    )
  end
  
  sync
  
  def self.from_database
    filter.first
  end
  
end