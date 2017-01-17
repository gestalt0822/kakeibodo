class AnalysesController < ApplicationController
 def index
   @categories = current_user.bookings.select(:category_id).distinct#該当ユーザの家計簿のcategory_idを重複なしで配列に
   @amounts = Array.new
   num = 0



   while num < @categories.count do
     @each_amount = Array.new
     @each_amount << Category.find(@categories[num].category_id).name
     @each_amount << current_user.bookings.where(category_id: @categories[num].category_id).sum(:amount)
     @each_amount << (current_user.bookings.where(category_id:@categories[num].category_id).sum(:amount).to_f/current_user.bookings.sum(:amount).to_f*100).round(2)
     @amounts << @each_amount
     num += 1
   end
  #@array= [[1,2,3,4],[11,12,13,14]]
 end
end
