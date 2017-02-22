module ApplicationHelper
  require 'redcarpet'

  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
  end

  def markdown(text)
   options = {
     filter_html: true,
     hard_wrap: true,
     link_attributes: { rel: 'nofollow', target: "_blank" }
   }

   extensions = {
     autolink: true,
     superscript: true,
     fenced_code_blocks: true,
     disable_indented_code_blocks: true,
     space_after_headers: true
   }

   renderer = Redcarpet::Render::HTML.new(options)
   markdown = Redcarpet::Markdown.new(renderer, extensions)

   markdown.render(text).html_safe
 end

end
