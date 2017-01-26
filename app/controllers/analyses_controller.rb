class AnalysesController < ApplicationController
 def index
   #該当ユーザの家計簿(今月分)のcategory_idを重複なしで配列に
   #this_month,except_this_month,listedはscope,bookings.rbを参照
   @categories_now = current_user.bookings.listed.this_month.select(:category_id).distinct

   #今月分の集計表の計算(配列の入れ子 (例[[食費,15000円,60%],[学習費,5000円,20%],[交通費,5000円,20%]])
   def amounts_now(categories)
     amounts_now = Array.new
     num = 0
     while num < categories.count do
       each_amount = Array.new
       each_amount << Category.find(categories[num].category_id).name#カテゴリー名
       each_amount << current_user.bookings.listed.where(category_id:categories[num].category_id).this_month.sum(:amount)#金額
       each_amount << (current_user.bookings.listed.where(category_id:categories[num].category_id).this_month.sum(:amount).to_f/current_user.bookings.listed.this_month.sum(:amount).to_f*100).round(1)
       amounts_now << each_amount
       num += 1
     end
     return amounts_now
   end
   @amounts_now = amounts_now(@categories_now)

   #今月分の円グラフの計算(配列の入れ子 (例[[食費,15000円],[学習費,5000円],[交通費,5000円]])、ChartkickのGemを使用　http://blog.engineer.adways.net/entry/32517011
   def graph_now(categories)
     amounts_now = Array.new
     num = 0
     while num < categories.count do
       each_amount = Array.new
       each_amount << Category.find(categories[num].category_id).name#カテゴリー名
       each_amount << current_user.bookings.listed.where(category_id:categories[num].category_id).this_month.sum(:amount)#金額
       amounts_now << each_amount
       num += 1
     end
     return amounts_now
   end
   @graph_now = graph_now(@categories_now)

   #該当ユーザの家計簿(先月までの分)のcategory_idを重複なしで配列に
   @categories_then = current_user.bookings.listed.except_this_month.select(:category_id).distinct

   #先月までの分の集計表の計算
   def amounts_then(categories)
     amounts_then = Array.new
     num = 0
     while num < categories.count do
       each_amount = Array.new
       each_amount << Category.find(categories[num].category_id).name
       each_amount << current_user.bookings.listed.where(category_id: categories[num].category_id).except_this_month.sum(:amount)
       each_amount << (current_user.bookings.listed.where(category_id: categories[num].category_id).except_this_month.sum(:amount).to_f/current_user.bookings.where(unlist: false).except_this_month.sum(:amount).to_f*100).round(1)
       amounts_then << each_amount
       num += 1
     end
     return amounts_then
   end
   @amounts_then = amounts_then(@categories_then)

   #先月までの分の円グラフの計算
   def graph_then(categories)
     amounts_then = Array.new
     num = 0
     while num < categories.count do
       each_amount = Array.new
       each_amount << Category.find(categories[num].category_id).name
       each_amount << current_user.bookings.listed.where(category_id: categories[num].category_id).except_this_month.sum(:amount)
       amounts_then << each_amount
       num += 1
     end
     return amounts_then
   end
   @graph_then = graph_then(@categories_then)
  end
end
