module ApplicationHelper
    def link_to_add_fields(name, form, association)
      new_object = form.object.send(association).klass.new
      id = new_object.object_id
      fields = form.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize + "_fields", form: builder)
      end
      link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def sortable(column, title = nil)
      title ||= column.titleize
      direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
      link_to title, :sort => column, :direction => direction
    end
    
  end