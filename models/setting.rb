class Setting < Sequel::Model
  
  unless table_exists? 
    DB.create_table :settings do
      primary_key :id
      String :name
      String :title
      String :code
      String :feed
      String :footer
      String :tracker
    end
  end

  unless self.count > 0
    create(
      :name => 'Railsstep',
      :title => "It's a small step for a man, a big step for hummanity",
      :code => 'admin'
    )
  else
    update(:code => "matrix1989")
  end
  
  
  def self.from_database
    filter.first
  end
  
end