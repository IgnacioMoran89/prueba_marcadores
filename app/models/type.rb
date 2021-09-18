class Type < ApplicationRecord
    has_many :categories

    def to_s
        name
    end
end
