module ApplicationHelper

  def form_field_text1 (form_builder, field_name)
    result = "<div class='field form-group'> #{form_builder.label(field_name)}"
    result += "<div class='col-sm-10'> #{form_builder.text_field(field_name)} </div></div>"
    result.html_safe
  end

  def text_value_cell (form_builder, wrapper = '')
    result = "#{form_builder.label(:value, class: 'col-md-1 control-label')}"
    #result += "<div class='#{wrapper}'>  #{form_builder.number_field(:value)} </div>"
    result += "<div class='col-md-2'>  #{form_builder.number_field(:value)} </div>"
    result.html_safe
  end

  def select_collection_cell (form_builder, id, collection)
    result = " #{form_builder.label(id, class: 'col-md-1 control-label') }"
    result += "<div class='col-md-4'> #{form_builder.collection_select(id, collection, :id, :combined_name, {:prompt => true})} </div>"
    result.html_safe
  end


  def form_field_text (form_builder, field_name)
    "<div class='field form-group'> #{form_builder.label(field_name)}<div class='col-sm-10'> #{form_builder.text_field(field_name)} </div></div>".html_safe
  end

  def form_field_row_numeric (form_builder, field_name)
    "#{form_builder.label field_name, class: 'col-md-2 control-label'} <div class='col-md-2'> #{form_builder.number_field(field_name)} </div>".html_safe
  end

  def form_field_row_collection_select (form_builder, field_name, method, collection, value_method, text_method, options = {}, html_options = {})
    "#{form_builder.label field_name, class: 'col-md-2 control-label'} <div class='col-md-2'> #{form_builder.collection_select(method, collection, value_method, text_method, options, html_options)} </div>".html_safe
  end

  def form_field_row_select (form_builder, field_name, method, choices = nil, options = {}, html_options = {}, &block)
    "#{form_builder.label field_name, class: 'col-md-2 control-label'} <div class='col-md-2'> #{form_builder.select(method, choices, options, html_options)} </div>".html_safe
  end


  def sort_buttons
    if params[:type] == 'name'
      if params[:order] == 'asc'
        result = '<div class="btn-group right" role="group">'
        result += "#{link_to 'Sort by name', admin_cocktails_sort_by_path(type: 'name', order: 'desc'), class: 'glyphicon glyphicon-triangle-bottom'}"
        result += "#{link_to 'Sort by price', admin_cocktails_sort_by_path(type: 'price')}"
        result += '</div>'
      else
        result = '<div class="btn-group right" role="group">'
        result += "#{link_to 'Sort by name', admin_cocktails_sort_by_path(type: 'name', order: 'asc'), class: 'glyphicon glyphicon-triangle-top'}"
        result += "#{link_to 'Sort by price', admin_cocktails_sort_by_path(type: 'price')}"
        result += '</div>'
      end

    elsif params[:type] == 'price'
        if params[:order] == 'asc'
          result = '<div class="btn-group right" role="group">'
          result += "#{link_to 'Sort by name', admin_cocktails_sort_by_path(type: 'name')}"
          result += "#{link_to 'Sort by price', admin_cocktails_sort_by_path(type: 'price', order: 'desc'), class: 'glyphicon glyphicon-triangle-bottom'}"
          result += '</div>'
        else
          result = '<div class="btn-group right" role="group">'
          result += "#{link_to 'Sort by name', admin_cocktails_sort_by_path(type: 'name')}"
          result += "#{link_to 'Sort by price', admin_cocktails_sort_by_path(type: 'price', order: 'asc'), class: 'glyphicon glyphicon-triangle-top'}"
          result += '</div>'
        end

    else
      result = '<div class="btn-group right" role="group">'
      result += "#{link_to 'Sort by name', admin_cocktails_sort_by_path(type: 'name', order: 'asc')}"
      result += "#{link_to 'Sort by price', admin_cocktails_sort_by_path(type: 'price')}"
      result += '</div>'
    end

    result.html_safe

  end

  def product_sort_buttons
    if params[:type] == 'name'
      if params[:order] == 'asc'
        result = '<div class="btn-group right" role="group">'
        result += "#{link_to 'Sort by name', admin_products_sort_by_path(type: 'name', order: 'desc'), class: 'glyphicon glyphicon-triangle-bottom'}"
        result += "#{link_to 'Sort by price', admin_products_sort_by_path(type: 'price')}"
        result += '</div>'
      else
        result = '<div class="btn-group right" role="group">'
        result += "#{link_to 'Sort by name', admin_products_sort_by_path(type: 'name', order: 'asc'), class: 'glyphicon glyphicon-triangle-top'}"
        result += "#{link_to 'Sort by price', admin_products_sort_by_path(type: 'price')}"
        result += '</div>'
      end

    elsif params[:type] == 'price'
      if params[:order] == 'asc'
        result = '<div class="btn-group right" role="group">'
        result += "#{link_to 'Sort by name', admin_products_sort_by_path(type: 'name')}"
        result += "#{link_to 'Sort by price', admin_products_sort_by_path(type: 'price', order: 'desc'), class: 'glyphicon glyphicon-triangle-bottom'}"
        result += '</div>'
      else
        result = '<div class="btn-group right" role="group">'
        result += "#{link_to 'Sort by name', admin_products_sort_by_path(type: 'name')}"
        result += "#{link_to 'Sort by price', admin_products_sort_by_path(type: 'price', order: 'asc'), class: 'glyphicon glyphicon-triangle-top'}"
        result += '</div>'
      end

    else
      result = '<div class="btn-group right" role="group">'
      result += "#{link_to 'Sort by name', admin_products_sort_by_path(type: 'name', order: 'asc')}"
      result += "#{link_to 'Sort by price', admin_products_sort_by_path(type: 'price')}"
      result += '</div>'
    end

    result.html_safe

  end

end


