class ReportsController < ApplicationController
  def index
   @rows = ActiveRecord::Base.connection.select_all(
      "
        select count(*) as num_times_played, b.user_id_1, b.user_id_2
        from (
            select a.team_id, a.user_id_1, a.user_id_2
            from (
                select team_id, user_id as user_id_1, 0 as user_id_2 from players
                union
                select team_id,                    0,        user_id from players
            ) as a
            group by a.team_id
            having count(*) = 2
        ) as b
        group by b.user_id_1, b.user_id_2
      "
    )
  end
end
