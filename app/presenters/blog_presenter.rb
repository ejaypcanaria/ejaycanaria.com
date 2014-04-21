class BlogPresenter < ApplicationPresenter

  def created_at
    @base.created_at.strftime("%b %d %Y %l:%M:%S %p")
  end

  def status
    label_type =
    if @base.status == 'drafted'
      'label-primary'
    elsif @base.status == 'published'
      'label-success'
    else
      'label-info'
    end

    "<span class='label #{label_type}'>#{@base.status.titleize}</span>".html_safe
  end

  def shortened_contents
    shorten(@base.contents, '...', 180)
  end
end
