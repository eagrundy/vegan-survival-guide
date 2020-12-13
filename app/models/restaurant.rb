class Restaurant < ActiveRecord::Base
    belongs_to :user

    validates :name, :options, :source, :image_url, presence: true
    # validates :options, presence: true
    # validates :source, presence: true
    # validates :image_url, presence: true
end
