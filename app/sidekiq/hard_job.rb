class HardJob
  include Sidekiq::Job

  def perform_mail_for_technical_inspection
    @cars = Car.all 

    invalid_cars = @cars.select do |car|
      car.technical_control.valid_until >= Date.current && car.technical_control.valid_until <= 1.week.from_now.to_date
    end

    invalid_cars.each do |car|
      UserMailer.technical_inspection_email(car).deliver_now
    end
  end
end
