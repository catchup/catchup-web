class CardObserver
  Subscriber = Struct.new(:model, :originated_by)

  def self.publish(event, model, originated_by, params = nil)
    new.publish(event, model, originated_by, params)
  end

  def publish(event, model, originated_by, params)
    observers_classes.each do |observer_class|
      observer = observer_class.new(model, originated_by)

      if params
        observer.send(event, params)
      else
        observer.send(event)
      end
    end
  end

  private

  def observers_classes
    [::CardRealtime, ::CardMailSender]
  end
end
