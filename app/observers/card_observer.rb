class CardObserver
  def self.publish(event, model, originated_by, params = nil)
    new.publish(event, model, originated_by, params)
  end

  def publish(event, model, originated_by, params)
    observers.each do |observer|
      if params
        observer.send(event, model, originated_by, params)
      else
        observer.send(event, model, originated_by)
      end
    end
  end

  private

  def observers
    [::CardRealtime, ::CardMailSender]
  end
end
