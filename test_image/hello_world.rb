i = 0

while true
  puts "Hello World #{i}"
  STDOUT.flush
  sleep(rand(10))
  i += 1
end
