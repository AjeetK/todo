class TodosController < ApplicationController
	def index
		#@user_todo = User.find(:all, :conditions => ['user_id = ?', current_user.id])
		#@todo = @user_todo.tasks.find_all_by_done(false)
		#@todo = Task.find(:all, :conditions => ['user_id = ? AND done = ?', current_user.id, false])
		@todo = Task.where(done: false, user_id: current_user.id).order('priority')
		@tododone = Task.where(done: true, user_id:current_user.id)
		
	end

	def new
			@todo = Task.new
	end

	def todo_params
		params.require(:task).permit(:name, :done, :user_id, :priority)
		
	end

	def create
		@todo = Task.new(todo_params)
		if @todo.save
			redirect_to todos_path, :notice =>"Your todo is saved"
		else
			render 'new'
		end
		
	end

	def update
		@todo = Task.find(params[:id])
		
		if @todo.update_attribute(:done, true)
			redirect_to todos_path, :notice => "Your todo is marked as done"
		else
			render 'edit'
		end
	end

	def destroy
		@todo = Task.find(params[:id])
		@todo.destroy
		redirect_to root_path, :notice => "Your todo was deleted"
		
	end
end
