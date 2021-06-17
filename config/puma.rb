require_relative  '../lib/heartbeat'

workers 1
after_worker_boot do
  
end

ENV['PORT']=@config.options.user_options[:Port]
puts "PORT  = #{ENV['PORT']}"
heartbeat = Heartbeat.new
# heartbeat.start()

@thr_stop = false 
@thr = Thread.new do
  loop do
    stop_requested = @thr_stop
    heartbeat.publish()
    break if stop_requested
    sleep ENV['HEARTBEAT_FREQUENCY'].to_i
  end
end