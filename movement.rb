class Timer
  attr_accessor :work_time, :break_time

  def initialize(work_time, break_time)
    @work_time = work_time
    @break_time = break_time
  end

  def run_timer()
    puts "Work Timer active"
    sleep(work_time)
    # binding.pry
    popup("work")
    puts "Break Timer active"
    sleep(break_time)
    popup("break")
  end

  def popup(process)
    image = ""
    title = ""
    body = ""
    if process == "work"
      # linux command
      # system("notify-send -u critical -i ~/programming/side-projects/pomodoro/assets/break.jpeg 'Time for a break' 'take a chill Pill'")
      system("osascript -e 'display notification \"Switch desk position & break!\" sound name \"Hero\"'")
    else
      # system("notify-send -u critical -i ~/programming/side-projects/pomodoro/assets/work.png 'Back to work' 'You got this shit'")
      system("osascript -e 'display notification \"Back to it\" sound name \"Submarine\"'")
    end
  end
end

loop do
  system("clear")
  #TODO: clean up, break out full day into method
  puts "======= Pomodoro Timer ======="
  puts "start full day sequence? (y/n)"
  if gets.chomp == "y"
    work = 50 * 60
    chill = 10 * 60
    timer = Timer.new(work, chill)
    loop do
      hour = Time.now.hour
      if hour < 14
        timer.run_timer
      elsif hour = 14
        system("osascript -e 'display notification \"Lunch Time!\" sound name \"Submarine\"'")
        puts "Lunch Time"
      elsif hour = 18
        system("osascript -e 'display notification \"Quittin Time\" sound name \"Submarine\"'")
        puts "Quittin time"
      end
      timer.run_timer
    end
  else
    puts "Enter a work time (in minutes)"
    work = gets.chomp.to_i * 60
    puts "Enter a break time (in minutes)"
    chill = gets.chomp.to_i * 60
    timer = Timer.new(work, chill)
    timer.run_timer
  end

  puts "Run timer again? (y/n)"
  break if gets.chomp == "n"
end
