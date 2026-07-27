class Player < ActiveRecord::Base
  belongs_to :team, optional: true

  def total_skill
    batting + running + pitching + fielding
  end
end
