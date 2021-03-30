# frozen_string_literal: true

class Page < ApplicationRecord
  has_many :pages, dependent: :destroy
  belongs_to :page, optional: true

  alias_attribute :parent, :page

  validates :name, presence: true
  validates :name, format: { with: /\A[A-Za-zА-Яа-я_\d]*\Z/i }

  before_create :iterate_nesting

  def childs
    Page.where(page_id: id)
  end

  def generate_tree
    # not optimized, a lot of database requests
    tree = open_paragraph
    childs.each do |children|
      tree += children.generate_tree
    end
    tree += close_paragraph
  end

  def open_paragraph
    "<div style=\"text-indent:#{nesting * 10}px;\">
		  <a href=\"#{path}\">#{name}</a>"
  end

  def close_paragraph
    "</div>\n"
  end

  private

  def iterate_nesting
    self.nesting = parent.nesting + 1
  end
end
