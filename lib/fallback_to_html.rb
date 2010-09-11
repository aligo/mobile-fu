#ActionView::PathSet.send is not working
module ActionView
  
  class PathSet < Array
  
    def find(path, prefix = nil, partial = false, details = {}, key = nil)
      template = find_all(path, prefix, partial, details, key).first
      if (details[:formats] == [:mobile]) && !template
        # details is frozen
        new_details = details.dup
        new_details[:formats] = [:html]
        template = find_all(path, prefix, partial, new_details, key).first
      end
      raise MissingTemplate.new(self, "#{prefix}/#{path}", details, partial) unless template
      template
    end
  
  end
  
end