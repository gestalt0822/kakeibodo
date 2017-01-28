module ApplicationHelper

  #現在のユーザのstatus1のchallengeのレコード及びそのdeadlineカラムの値を取得
  def finish_or_continue?
    if current_user.challenges.find_by(status:1)
      day_last = current_user.challenges.find_by(status:1).deadline
      day_now = Date.today
      if day_now > day_last
        return true
      else
        return false
      end
    return true
    end
  end

  def which_user?(index)
    if index == 1
      @user_rank = "gold"
      return  @user_rank
    elsif index == 2
      @user_rank = "silver"
      return @user_rank
    elsif index == 3
      @user_rank = "bronze"
      return @user_rank
    else
      @user_rank= "each"
      return @user_rank
    end
  end

  def which_medal?(index)
    if index == 1
      return image_tag('0173_gold.png', size: '130x130', class:'img-responsive medal')
    elsif index == 2
      return image_tag('0172_silver.png', size: '130x130', class:'img-responsive medal')
    elsif index == 3
      return image_tag('0171_bronze.png', size: '130x130', class:'img-responsive medal')
    else
    end
  end

  def which_rank?(index)
    if index == 1
      return  1
    elsif index == 2
      return 2
    elsif index == 3
      return 3
    else
    end
  end

  def user_image(user)
    if user.avatar.present?
      return image_tag(user.avatar, size: '130x130', class:'img-responsive user_image')
    else
      return image_tag('no_image.png', size: '130x130', class:'img-responsive user_image')
    end
  end
end
