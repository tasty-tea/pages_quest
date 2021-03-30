class ApplicationController < ActionController::Base

	private

		#Will replace custom tag markdown with the HTML tags
	def construct_html(text)
		#B_MASK replacement will match the link part of the LINK_MASK, so links tag should match before bold tag
		b_mask = /(\[)(.*?)(\])/s
		i_mask = /(\\\\)(.*?)(\\\\)/s
		link_mask = /(\(\()(.*?) (\[(.*?)\])(\)\))/s

		text = text.gsub(link_mask) { "<a href=\"#{$2}\">#{$4}</a>"}
		text = text.gsub(b_mask) { "<b>#{$2}</b>" }
		text = text.gsub(i_mask) { "<i>#{$2}</i>" }
	end

	#Will replace HTML tags with custom tag markdown
	def deconstruct_html(text)
		html_b_mask = /(<b>)(.*?)(<\/b>)/s
		html_i_mask = /(<i>)(.*?)(<\/i>)/s
		html_link_mask = /(<a href=\")(.*?)(\">)(.*?)(<\/a>)/s

		text = text.gsub(html_link_mask) { "((#{$2} [#{$4}]))"}
		text = text.gsub(html_b_mask) { "[#{$2}]" }
		text = text.gsub(html_i_mask) { "\\\\#{$2}\\\\" }
	end
end
