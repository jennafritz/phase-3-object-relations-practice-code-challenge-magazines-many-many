require 'pry'

class Magazine < ActiveRecord::Base
    has_many :subscriptions
    has_many :readers, through: :subscriptions

    def email_list
        email_array = self.readers.map do |reader_instance|
            reader_instance.email
        end
        email_array.join(";")
    end

    def subscriber_count
        self.subscriptions.count
    end

    def self.most_popular
        subscribes_array = self.all.sort do |magazine_instance_a, magazine_instance_b|
            magazine_instance_a.subscriber_count <=> magazine_instance_b.subscriber_count
        end
        subscribes_array.last
    end
end