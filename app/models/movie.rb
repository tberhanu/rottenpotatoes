class Movie < ActiveRecord::Base
    def self.all_ratings
        %w(G PG PG-13 NC-17 R) # ["G", "PG", "PG-13", "NC-17", "R"]
    end
    validates :title, :release_date, :presence => true
    # validate :release_date, :presence => true
    validate :released_1930_or_later
    def released_1930_or_later
        if release_date && release_date < Date.parse('1 Jan 1930')
            errors.add(:release_date, 'must be on or after 1930') 
        end
    end
    validates :rating, :inclusion => {:in => Movie.all_ratings}, :unless => :grandfathered?
    @@grandfathered_date = Date.parse('1 Nov 1968')
    def grandfathered?
        release_date && release_date < @@grandfathered_date
    end
end
