FactoryGirl.define do
  factory :message do
    to ENV['SAMPLE_RECEIVER_PHONE_NUMBER']
    from ENV['SAMPLE_SENDER_PHONE_NUMBER']
    body 'Jenny I got your number'
  end
end
