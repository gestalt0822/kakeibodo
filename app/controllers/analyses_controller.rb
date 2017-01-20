class AnalysesController < ApplicationController
 def index
   @categories_now = current_user.bookings.where.not(unlist: true).where(date: Time.now.beginning_of_month..Time.now.end_of_month).select(:category_id).distinct#該当ユーザの家計簿のcategory_idを重複なしで配列に
   @amounts_now = Array.new
   num = 0

   while num < @categories_now.count do
     @each_amount = Array.new
     @each_amount << Category.find(@categories_now[num].category_id).name#カテゴリー名
     @each_amount << current_user.bookings.where.not(unlist: true).where(category_id: @categories_now[num].category_id).sum(:amount)#金額
     @each_amount << (current_user.bookings.where(category_id:@categories_now[num].category_id).where.not(unlist: true).where(date: Time.now.beginning_of_month..Time.now.end_of_month).sum(:amount).to_f/current_user.bookings.where.not(unlist: true).where(date: Time.now.beginning_of_month..Time.now.end_of_month).sum(:amount).to_f*100).round(1)
     @amounts_now << @each_amount
     num += 1
   end

   @categories_then = current_user.bookings.where.not(unlist: true).where.not(unlist: true).where.not(date: Time.now.beginning_of_month..Time.now.end_of_month).select(:category_id).distinct#該当ユーザの家計簿のcategory_idを重複なしで配列に
   @amounts_then = Array.new
   num = 0

   while num < @categories_then.count do
     @each_amount = Array.new
     @each_amount << Category.find(@categories_then[num].category_id).name
     @each_amount << current_user.bookings.where.not(unlist: true).where(category_id: @categories_then[num].category_id).sum(:amount)
     @each_amount << (current_user.bookings.where(category_id:@categories_then[num].category_id).where.not(unlist: true).where.not(date: Time.now.beginning_of_month..Time.now.end_of_month).sum(:amount).to_f/current_user.bookings.where.not(unlist: true).where.not(date: Time.now.beginning_of_month..Time.now.end_of_month).sum(:amount).to_f*100).round(1)
     @amounts_then << @each_amount
     num += 1
   end
 end


end
