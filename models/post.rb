class Post < Sequel::Model
  
  #set_schema do
  #   primary_key :id
  #   String :title
  #   String :text
  #   datetime :date
  #   String :link
  # end
  unless table_exists? 
    DB.create_table :posts do
      primary_key :id
      text :title
      text :text
      Datetime :date
      text :link
    end
  end

  unless self.count > 0
    create(
      :title => 'Welcome!',
      :text => File.open('README.textile', 'r') { |file| file.read },
      :date => Time.now,
      :link => 'welcome'
    )
  end
  
  def self.ordered(page = 1)
    filter.order(:date.desc).paginate(page.to_i, PAGE_SIZE)
  end
  
  def self.search(q)
    value = "%#{q}%"
    filter(:title.like(value) | :text.like(value)).order(:date.desc)
  end
  
  def self.with_link(value)
    filter(:link => value).order(:date.desc)
  end
  
end