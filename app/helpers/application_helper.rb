module ApplicationHelper

  def edit_and_destroy_buttons(item)
    unless current_user.nil?
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-primary white-text")
      del = link_to('Destroy', item, method: :delete,
                    data: {confirm: 'Are you sure?' }, class:"btn btn-danger white-text")
      if current_is_admin
        raw("#{edit} | #{del}")
      elsif current_user
      	raw("#{edit}")
      else
      	raw("#{edit} | #{del}")
      end
    end
  end

  def round(decimal)
  	number_with_precision(decimal, precision: 2)
  end

end
