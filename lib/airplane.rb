require 'pry'

class Airplane
  attr_reader :type, :wing_loading, :horsepower, :start, :land, :takeoff
  attr_accessor :started, :flying, :landed, :fuel

  def initialize(type, wing_loading, horsepower, fuel)
    @type = type
    @wing_loading = wing_loading
    @horsepower = horsepower
    @started = false
    @flying = false
    @takeoff = false
    @landed = false
    @fuel = fuel
  end

  def start
    if !@started && @fuel >= 25
      puts "The airplane started!\n"
      @started = true
      @fuel -= 25
    elsif @started
      puts "The airplane has already been running!\n"
    elsif !@started && @fuel < 25
      puts "The airplane cannot be started; you need to add fuel!\n"
    end
  end

  def takeoff
    if @started && @fuel >= 25
      puts "The plane has taken off.\n"
      @flying = true
      @fuel -= 25
    elsif @started && @fuel < 25
      puts "The plane does not have enough fuel to take off.\n"
    elsif !@started
      puts "The plane has not been started; please start.\n"
    end
  end

  def land
    if @flying && @fuel >= 100
      puts "The airplane has landed!\n"
      @landed = true
      @flying = false
      @fuel -= 100
    elsif @flying && @fuel < 100
      puts "The airplane does not have enough fuel to land - prepare for emergency landing!"
    elsif !@flying && @started
      puts "The airplane is already on the ground!\n"
    elsif !@flying && !@started
      puts "The airplane must be started in order to fly!\n"
    end
  end
end
