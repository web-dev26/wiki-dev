# coding: utf-8
class Page < ActiveRecord::Base

  belongs_to :parent, class_name: "Page", foreign_key: "parent_id"
  has_many :children, class_name: "Page", foreign_key: "parent_id"

  validates_format_of :name, with: /[a-zA-Z0-9\_А-Яа-я]\z/
  
  
  before_save :fix_text
  
  def get_full_path()
    if (self.new_record?)
      return ""
    else
    if self.parent == nil
        ("/" + self.name)
    else
        (self.parent.get_full_path() + "/" + self.name)
    end
    end
  end
  
  
 protected
  def fix_text()
    self.text_convert =  text_prime.gsub(/(.?)\*\*(.+?)\*\*([^\*]?)/m) { "#{$1}<b>#{$2}</b>#{$3}" }.gsub(/(.?)\\\\(.+?)\\\\([^\\]?)/m) { "#{$1}<i>#{$2}</i>#{$3}" }.gsub(/\(\((.+?)\s\[(.+?)\]\)\)/) { "<a href=\"#{$1}\">#{$2}</a>" }
  end
end
