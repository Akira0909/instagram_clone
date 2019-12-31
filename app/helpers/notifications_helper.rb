module NotificationsHelper
	
	def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
	end
	
	def notification_form(notification)
		@comment = nil
		visitor = link_to notification.visitor.user_name,
			notification.visitor, style:"font-weight: bold;"
		your_post = link_to 'あなたの投稿',
			notification.micropost, style:"font-weight: bold;"
		others_post = link_to "#{notification.visited.user_name}さんの投稿",
			micropost_path(notification.visited)
			
		case notification.action
		when "follow" then
			"#{visitor}があなたをフォローしました"
		when "like" then
			"#{visitor}が#{your_post}をお気に入りに追加しました"
		when "comment" then
			if notification.micropost.user_id == current_user.id
				"#{visitor}が#{your_post}にコメントしました"
			else
				"#{visitor}が#{others_post}にコメントしました"
			end
		end
	end
end