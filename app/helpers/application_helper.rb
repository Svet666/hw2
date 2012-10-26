module ApplicationHelper
 def sortable(column, title = nil)
  title ||= column.titleize
  @css_class = nil
  if column == sort_column
    @css_class = "hilite"
  end
  @direction = "ASC"
  if ((column == sort_column) && (sort_direction == "ASC")) 
    @direction = "DESC"
  end
  link_to title, {:sort => column, :direction => @direction}, {:class => @css_class}
 end
	
end
