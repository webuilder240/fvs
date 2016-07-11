require './source.rb'
fvs = Fvs.new()
Fvs.bulk do
  1000000.times do |i|
    fvs.create("nick_#{i}", "Takuya_#{i}")
  end
end