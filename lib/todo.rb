require_relative 'task'

class Todo

	def initialize
		@tasks =  File.exist?(Dir.home + '/.todo_list') ? Marshal.load(File.read(Dir.home + '/.todo_list')) : []
	end

	attr_reader :items

	def add(task)
		raise ArugmentError.new "Expecting add on type Task" unless task.kind_of? Task
		@tasks << task
		save_items
	end

	def remove(index)
		@tasks.delete_at(index - 1)
		save_items
	end

	def clear
		@tasks.clear
		save_items
	end

	def to_s
		if @tasks.empty?
			"No Current Tasks!"
		else
			tasks_string = ""
			@tasks.each_with_index do |item, index|
				tasks_string << "    #{index + 1} - #{item}\n"
			end
			return tasks_string
		end
	end

	private 

	def save_items
		File.open(Dir.home + '/.todo_list', "w") do |f|
			f.puts Marshal.dump(@tasks)
		end
	end

end