class CardsNotification
  def self.publish(event, model, params)
    new().publish(event, model, params)
  end

  def publish(event, model, params)
    observers.each do |observer|
      observer.send(event, model, params)
    end
  end

  private

  def observers
    [::CardRealtime, ::CardMailNotifier]
  end
end
