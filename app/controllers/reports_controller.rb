class ReportsController < ApplicationController
  def index
   @rows = ActiveRecord::Base.connection.select_all(
      "
        select count(*) as num_times_played, b.name as player_1, c.name as player_2
        from (
          
          select a.team_id, max(a.user_id_1) as user_id_1, max(a.user_id_2) as user_id_2
          from (
              select team_id, user_id as user_id_1, 0 as user_id_2 from players where position = 'Defense'
              union
              select team_id,                    0,        user_id from players where position = 'Offense'
          ) as a
          group by a.team_id
          
        ) as a join users as b on a.user_id_1 = b.id join users as c on a.user_id_2 = c.id
        group by a.user_id_1, a.user_id_2
      "
    )
  end
end
