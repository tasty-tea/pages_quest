# frozen_string_literal: true

module PagesHelper
  # Will replace custom tag markdown with the HTML tags
  def construct_html(text)
    # B_MASK replacement will match the link part of the LINK_MASK, so links tag should match before bold tag
    b_mask = /(\[)(.*?)(\])/s
    i_mask = /(\\\\)(.*?)(\\\\)/s
    link_mask = /(\(\()(.*?) (\[(.*?)\])(\)\))/s

    text = text.gsub(link_mask) { "<a href=\"#{Regexp.last_match(2)}\">#{Regexp.last_match(4)}</a>" }
    text = text.gsub(b_mask) { "<b>#{Regexp.last_match(2)}</b>" }
    text.gsub(i_mask) { "<i>#{Regexp.last_match(2)}</i>" }
  end

  # Will replace HTML tags with custom tag markdown
  def deconstruct_html(text)
    html_b_mask = %r{(<b>)(.*?)(</b>)}s
    html_i_mask = %r{(<i>)(.*?)(</i>)}s
    html_link_mask = %r{(<a href=\")(.*?)(\">)(.*?)(</a>)}s

    text = text.gsub(html_link_mask) { "((#{Regexp.last_match(2)} [#{Regexp.last_match(4)}]))" }
    text = text.gsub(html_b_mask) { "[#{Regexp.last_match(2)}]" }
    text.gsub(html_i_mask) { "\\\\#{Regexp.last_match(2)}\\\\" }
  end
end
