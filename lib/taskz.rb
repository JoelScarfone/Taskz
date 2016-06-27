#!/usr/bin/env ruby
require 'optparse'
require_relative 'task' 
require_relative 'todo' 

options = { :do_throughput_measurement => false, :query_string => '', :debug => false }

OptionParser.new do|opts|
	opts.banner = "Usage: taskz [options]"

	opts.on('-n', '--new task_name', 'Create a new task') do |task_name|
		options[:new] = task_name
	end

	opts.on('-c', '--complete index', 'Complete a task at \'index\'') do |index|
		options[:complete] = index
	end

	opts.on('-r', '--remove index', 'Remove a task at \'index\'') do |index|
		options[:remove] = index
	end

	opts.on('-w', '--wipe', 'Remove all tasks') do
		options[:wipe] = true
	end

	opts.on('-h', '--help', 'Displays help') do
		puts "\n#{opts}"
		puts
	exit
end

end.parse!

options_not_specified = [options[:new], options[:complete], options[:remove], options[:wipe]].count{ |x| x.nil? }

todo = Todo.new

if options_not_specified == 4
	puts "\nYour Taskz: "
	puts "-------------"
	puts todo
	puts
	exit
elsif options_not_specified !=3
	puts "\nError - Ceratin Taskz instructions are mutually exclusive. Use 'taskz --help' for more information.\n\n"
	exit
end

if options[:new]
	task = Task.new(options[:new])
	todo.add(task)
	puts "Task successfully added."
end

if options[:complete]
	todo.remove(options[:complete].to_i - 1)
	puts "Task successfully completed."
end

if options[:remove]
	todo.remove(options[:complete].to_i)
	puts "Task successfully removed."
end

if options[:wipe]
	todo.clear
	puts "Tasks cleared!"
end