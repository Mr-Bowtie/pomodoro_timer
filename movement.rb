class Timer
  attr_accessor :work_time, :break_time

  def initialize(work_time, break_time)
    @work_time = work_time
    @break_time = break_time
  end

  def run_timer()
    # make a secondary regular pom timer
    #TODO have a time checker inside this method to break for lunch and end of day at the right time
    #TODO use lambdas for Time.now.hour, break time check into method
    work_finish = Time.now.to_i + work_time
    break_finish = work_finish + break_time
    puts "Work Timer active"
    loop do
      break if Time.now.to_i >= work_finish || Time.now.hour == 14 || Time.now.hour == 18
      sleep 60
    end
    if Time.now.hour == 14
      popup("lunch")
      return
    elsif Time.now.hour == 18
      popup("eod")
      return
    else
      popup("work")
    end
    puts "Break Timer active"
    loop do
      break if Time.now.to_i >= break_finish || Time.now.hour == 14 || Time.now.hour == 18
      sleep 60
    end
    return if Time.now.hour == 14 || Time.now.hour == 18
    popup("break")
  end

  def popup(process)
    image = ""
    title = ""
    body = ""
    # turn into switch?
    if process == "work"
      # linux command
      # system("notify-send -u critical -i ~/programming/side-projects/pomodoro/assets/break.jpeg 'Time for a break' 'take a chill Pill'")
      system("osascript -e 'display notification \"Switch desk position & break!\" sound name \"Hero\"'")
    elsif process == "lunch"
      system("osascript -e 'display notification \"Lunch Time!\" sound name \"Submarine\"'")
    elsif process == "eod"
      system("osascript -e 'display notification \"Quittin Time\" sound name \"Submarine\"'")
    elsif process == "break"
      # system("notify-send -u critical -i ~/programming/side-projects/pomodoro/assets/work.png 'Back to work' 'You got this shit'")
      system("osascript -e 'display notification \"Back to it\" sound name \"Submarine\"'")
    end
  end
end

# loop do
system("clear")
#TODO: clean up, break out full day into method
puts "======= Pomodoro Timer ======="
# puts "start full day sequence? (y/n)"
# if gets.chomp == "y"
work = 50 * 60
chill = 10 * 60
timer = Timer.new(work, chill)
loop do
  hour = Time.now.hour
  if (hour < 14 || hour > 14)
    timer.run_timer
  elsif hour = 14
    puts "Lunch Time"
    while Time.now.hour == 14
      sleep 60
    end
  elsif hour = 18
    puts "Quittin time"
    break
  end
end
# else
#   puts "Enter a work time (in minutes)"
#   work = gets.chomp.to_i * 60
#   puts "Enter a break time (in minutes)"
#   chill = gets.chomp.to_i * 60
#   timer = Timer.new(work, chill)
#   timer.run_timer
# end

#   puts "Run timer again? (y/n)"
#   break if gets.chomp == "n"
# end
