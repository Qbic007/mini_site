require 'closure_tree'

class Page < ApplicationRecord

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9\/А-Яа-я]+\z/,
                                             message: "only allows letters or numbers" }

  before_save :raw_text

  acts_as_tree dependent: :destroy

  protected

  def raw_text
    self.content_raw = self.content.to_s.gsub(/(.?)\*\*(.+?)\*\*([^\*]?)/m) { "#{$1}<b>#{$2}</b>#{$3}" }
                          .gsub(/(.?)\\\\(.+?)\\\\([^\\]?)/m) { "#{$1}<i>#{$2}</i>#{$3}" }
                          .gsub(/\(\((.+?)\[(.+?)\]\)\)/) { "<a href=\"#{$1}\">#{$2}</a>" }
  end

end