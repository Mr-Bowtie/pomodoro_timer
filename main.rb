require 'pry'

class Timer
  attr_accessor :work_time, :break_time

  def initialize(work_time, break_time)
    @work_time = work_time
    @break_time = break_time
  end

  def run_timer()
    puts 'Work Timer active'
    sleep(work_time)
    # binding.pry
    popup('work')
    puts 'Break Timer active'
    sleep(break_time)
    popup('break')
  end

  def popup(process)
    image = ''
    title = ''
    body = ''
    if process == 'work'
      system("notify-send -u critical -i ~/programming/side-projects/pomodoro/assets/break.jpeg 'Time for a break' 'take a chill Pill'")
    else
      system("notify-send -u critical -i ~/programming/side-projects/pomodoro/assets/work.png 'Back to work' 'You got this shit'")
    end
  end
end

system('clear')

puts '======= Pomodoro Timer ======='
puts 'Enter a work time (in minutes)'
work = gets.chomp.to_i * 60
puts 'Enter a break time (in minutes)'
chill = gets.chomp.to_i * 60
timer = Timer.new(work, chill)
timer.run_timer
