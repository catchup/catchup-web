class CardObserver
  def self.publish(event, model, params = nil)
    new().publish(event, model, params)
  end

  def publish(event, model, params)
    observers.each do |observer|
      if params
        observer.send(event, model, params)
      else
        observer.send(event, model)
      end
    end
  end

  private

  def observers
    [::CardRealtime, ::CardMailNotifier]
  end
end
