FactoryGirl.define do
  factory :trend_report do
    title "Clothing expenses"
    x_label "date"
    y_label "spending"
    x_data [2,3,4]
    y_data [4,5,6]
  end
end
