class ApplicationPresenter
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  def initialize(base)
    @base = base
  end

protected
  def shorten(text, omission, length=100)
    truncate(strip_tags(text), length: length, omission: omission, separator: ' ' ).html_safe
  end

private
  def method_missing(method, *args)
    args.empty? ? @base.send(method) : @base.send(method, *args)
  end
end
