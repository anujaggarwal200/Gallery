class Album < ApplicationRecord
	has_one_attached:cover_image
	has_many_attached:image

	belongs_to :user
	has_and_belongs_to_many :tags


  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(tagname: name.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:tagname).join(", ")
  end
end
