class Blimp < ApplicationRecord
  scope :slow_query, -> {
    where("SELECT true FROM pg_sleep(1)").limit(10)
    # where("SELECT true FROM pg_sleep(1)")
  }
end
