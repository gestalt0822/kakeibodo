class AnalysesController < ApplicationController
 def index
   @categories_now = current_user.bookings.where(unlist: false).this_month.select(:category_id).distinct
   #該当ユーザの家計簿のcategory_idを重複なしで配列に

   def amounts_now(categories)
     amounts_now = Array.new
     num = 0
     while num < categories.count do
       each_amount = Array.new
       each_amount << Category.find(categories[num].category_id).name#カテゴリー名
       each_amount << current_user.bookings.where(category_id: categories[num].category_id, unlist:false).sum(:amount)#金額
       each_amount << (current_user.bookings.where(category_id:categories[num].category_id, unlist:false).this_month.sum(:amount).to_f/current_user.bookings.where.not(unlist: true).this_month.sum(:amount).to_f*100).round(1)
       amounts_now << each_amount
       num += 1
     end
     return amounts_now
   end
   @amounts_now = amounts_now(@categories_now)
   #this_monthはbookings.rbを参照

   @categories_then = current_user.bookings.where(unlist: false).except_this_month.select(:category_id).distinct
   #該当ユーザの家計簿のcategory_idを重複なしで配列に

   def amounts_then(categories)
     amounts_then = Array.new
     num = 0

     while num < categories.count do
       each_amount = Array.new
       each_amount << Category.find(categories[num].category_id).name
       each_amount << current_user.bookings.where(category_id: categories[num].category_id, unlist:false).sum(:amount)
       each_amount << (current_user.bookings.where(category_id: categories[num].category_id, unlist:false).except_this_month.sum(:amount).to_f/current_user.bookings.where(unlist: false).except_this_month.sum(:amount).to_f*100).round(1)
       amounts_then << each_amount
       num += 1
     end
     return amounts_then
   end

   @amounts_then = amounts_then(@categories_then)
   #except_this_monthはbookings.rbを参照
  end
end
