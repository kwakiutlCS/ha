Given(/^the following transactions exist:$/) do |table|
  table.hashes.each do |t|
    user = User.where(name: "palerma").first
    x = user.transactions.build(t)
    x.save
    
  end
end
