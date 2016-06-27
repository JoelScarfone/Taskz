class Task

	def initialize(name)
		@name = name
	end

	attr_reader :name
	
	def to_s
		"Task: #{@name}"
	end
	
end