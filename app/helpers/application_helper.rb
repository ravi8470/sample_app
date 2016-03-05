module ApplicationHelper
  def full_title(prvd_title)
    base_title= "Ruby on Rails tutorial Sample App"
    if prvd_title.empty?
      puts base_title
    else
      puts "#{base_title} | #{prvd_title}"
    end
  end
end
