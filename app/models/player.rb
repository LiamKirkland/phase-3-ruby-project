class Player < ActiveRecord::Base
  belongs_to :team, optional: true

  validates :batting, numericality: { in: 0..10 }
  validates :running, numericality: { in: 0..10 }
  validates :pitching, numericality: { in: 0..10 }
  validates :fielding, numericality: { in: 0..10 }

  def total_skill
    batting + running + pitching + fielding
  end
end
