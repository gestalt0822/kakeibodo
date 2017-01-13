module ApplicationHelper
  #現在のユーザのstatus1のchallengeのレコード及びそのdeadlineカラムの値を取得
  def finish_or_continue?
    day_now = Date.today
    day_last = current_user.challenges.find_by(status:1).deadline
    if day_now > day_last
      return true
    else
      return false
    end
  end
end
