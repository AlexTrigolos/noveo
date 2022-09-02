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

  enum newspaper_type: [:newspaper_type1, :newspaper_type2, :newspaper_type3]

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

  enum podcast_type: [:podcast_type1, :podcast_type2, :podcast_type3]

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
end

class CreateUserTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.timestamps
    end
  end
end

CreateUserTable.migrate(:up) unless ActiveRecord::Base.connection.table_exists?('users')

class Subscription < ActiveRecord::Base
  belongs_to :subscribable, polymorphic: true
  belongs_to :user
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

# rubocop:enable Style/Documentation

CreateSubscriptionTable.migrate(:up) unless ActiveRecord::Base.connection.table_exists?('subscriptions')

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

Newspaper.destroy_all
Newspaper.create!(name: 'first_newspaper', newspaper_type: 0)
Newspaper.create!(name: 'second_newspaper', newspaper_type: 1)
# Newspaper.create(name: 'third_newspaper', newspaper_type: 2222)

Podcast.destroy_all
Podcast.create!(name: 'first_podcast', podcast_type: 0)
Podcast.create!(name: 'second_podcast', podcast_type: 1)
# Podcast.create(name: 'third_podcast', podcast_type: 2222)

# Subscription.create!(newspaper: Newspaper.first, user: User.first, podcast: Podcast.first)
# Subscription.create!(newspaper: Newspaper.second, podcast: Podcast.second, user: User.second)
# # Subscription.create(newspaper: Newspaper.third, podcast: Podcast.third, user: User.third)
# Subscription.create!(newspaper: Newspaper.first, user: User.second, podcast: Podcast.first)
Subscription.create!(subscribable: Newspaper.first, user: User.first)
Subscription.create!(subscribable: Podcast.first, user: User.first)

# first_subs = Subscription.first.as_json(only: %i[id user_id newspaper_id podcast_id])
# third_subs = Subscription.third.as_json(only: %i[id user_id newspaper_id podcast_id])
# p first_subs, third_subs
# p User.find_by(id: first_subs['user_id'].to_i)
# p User.find_by(id: third_subs['user_id'].to_i)
