class Post < Sequel::Model
  

  Sequel::Model.plugin(:schema)  

  set_schema do
    set_primary_key :id
    String :title
    String :text
    datetime :date
    String :link
  end
  
  unless table_exists?
    create_table
    create(
      :title => 'Welcome!',
      :text => File.open('README.textile', 'r') { |file| file.read },
      :date => Time.now,
      :link => 'welcome'
    )
  end
  
  sync
  
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