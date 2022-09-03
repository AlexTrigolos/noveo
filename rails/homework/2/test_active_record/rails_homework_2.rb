# frozen_string_literal: true

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'test_active_record',
  password: 'administrator',
  database: 'active_record_db'
)

# rubocop:disable Style/GlobalStdStream
ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
# rubocop:enable Style/GlobalStdStream

class Newspaper < ActiveRecord::Base
  has_many :subscriptions, as: :subscribable

  enum newspaper_type: %i[newspaper_type1 newspaper_type2 newspaper_type3]

  validates :name, presence: true, uniqueness: true
  validates :newspaper_type, inclusion: { in: newspaper_types.keys }
end

# rubocop:disable Style/Documentation
class CreateNewspaperTable < ActiveRecord::Migration[7.0]
  def change
    create_table :newspapers do |t|
      t.string :name, null: false, unique: true
      t.integer :newspaper_type, null: false
      t.timestamps
    end
  end
end

CreateNewspaperTable.migrate(:up) unless ActiveRecord::Base.connection.table_exists?('newspapers')

class Podcast < ActiveRecord::Base
  has_many :subscriptions, as: :subscribable

  enum podcast_type: %i[podcast_type1 podcast_type2 podcast_type3]

  validates :name, presence: true, uniqueness: true
  validates :podcast_type, inclusion: { in: podcast_types.keys }
end

class CreatePodcastTable < ActiveRecord::Migration[7.0]
  def change
    create_table :podcasts do |t|
      t.string :name, null: false, unique: true
      t.integer :podcast_type, null: false
      t.timestamps
    end
  end
end

CreatePodcastTable.migrate(:up) unless ActiveRecord::Base.connection.table_exists?('podcasts')

class User < ActiveRecord::Base
  has_many :subscriptions

  validates :username, presence: true, uniqueness: true

  before_update :update_subscriptions

  private

  def update_subscriptions
    Subscription.find_each do |sub|
      if sub.user_id == id
        if active
          sub.active!
        else
          sub.disabled!
        end
      end
    end
  end
end

class CreateUserTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.timestamps
    end
  end
end

class AddActiveToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :active, :boolean, default: true, null: false
  end
end

unless ActiveRecord::Base.connection.table_exists?('users')
  CreateUserTable.migrate(:up)
  AddActiveToUser.migrate(:up)
end

class Subscription < ActiveRecord::Base
  belongs_to :subscribable, polymorphic: true
  belongs_to :user

  enum subscription_status: %i[active disabled inactive]

  validates :subscription_status, inclusion: { in: subscription_statuses.keys }
end

class CreateSubscriptionTable < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :subscribable, null: false, polymorphic: true
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end

class AddStatusToSubscription < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :subscription_status, :integer, default: 0, null: false
  end
end

# rubocop:enable Style/Documentation
unless ActiveRecord::Base.connection.table_exists?('subscriptions')
  CreateSubscriptionTable.migrate(:up)
  AddStatusToSubscription.migrate(:up)
end

# CreateSubscriptionTable.migrate(:down)
# CreatePodcastTable.migrate(:down)
# CreateNewspaperTable.migrate(:down)
# CreateUserTable.migrate(:down)

Subscription.destroy_all

User.destroy_all
user = User.new(username: 'alex')
user.save
User.create!(username: 'mary')
User.create(username: 'alex')
# user.update(active: true)

Newspaper.destroy_all
Newspaper.create!(name: 'first_newspaper', newspaper_type: 0)
Newspaper.create!(name: 'second_newspaper', newspaper_type: 1)
# Newspaper.create(name: 'third_newspaper', newspaper_type: 2222)

Podcast.destroy_all
Podcast.create!(name: 'first_podcast', podcast_type: 0)
Podcast.create!(name: 'second_podcast', podcast_type: 1)
# Podcast.create(name: 'third_podcast', podcast_type: 2222)

# Subscription.create!(newspaper: Newspaper.first, user: User.first, podcast: Podcast.first)
Subscription.create!(subscribable: Newspaper.first, user: User.first)
Subscription.create!(subscribable: Podcast.first, user: User.second)
Subscription.second.disabled!
p User.first.as_json
User.first.update(active: false)
p User.first.as_json
p Subscription.first.as_json
p Subscription.second.as_json
User.first.update(active: true)
p User.first.as_json
p Subscription.first.as_json
p Subscription.second.as_json
