class Notification < ActiveRecord::Base
  belongs_to :notifiable, :polymorphic => true

  # def create_notification_text
    # send("changed_" + item_changed)
  # end

  #creates text for notifications base on and changed_ method in model that was changed and @notification#item_changed
  def meta_desc
    @notifiable = notifiable
    method_to_call = Notification.define_notification_text("changed_#{item_changed}")
    self.send(method_to_call)
  end

  def self.define_notification_text(name)
    if !name.match(/changed_(.*)_id/).nil?
      caps = name.match(/changed_(.*)_id/).captures[0]
      define_method(caps) do
        return caps.capitalize.constantize.send("was_changed")
      end
    else
      define_method(name) do
        return @notifiable.send(name)
      end
    end
  end


end
