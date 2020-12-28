class Restaurant < ActiveRecord::Base
    belongs_to :user

    validates :name, :options, :source, :image_url, presence: true

    # def self.search(search)
    #     where("name like ?", "%#{search}%")
    # end

end
