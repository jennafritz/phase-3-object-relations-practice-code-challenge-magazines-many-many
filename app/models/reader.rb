class Reader < ActiveRecord::Base
    has_many :subscriptions
    has_many :magazines, through: :subscriptions

    def subscribe(magazine, price)
        new_sub = Subscription.create(price: price, magazine_id: magazine.id, reader_id: self.id)
        new_sub
    end

    def total_subscription_price
        total = 0
        self.subscriptions.map do |subscription_instance|
            total = total + subscription_instance.price
        end
        total
    end

    def cancel_subscription(magazine)
        self.subscriptions.find_by(magazine_id: magazine.id).destroy
    end
end