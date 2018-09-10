class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /todos
  def index
    render json: Todo.all
  end

  # POST /todos
  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo
    else
      render :json => { errors: todo.errors.full_messages }, :status => 422
    end
  end

  # DELETE /todos/:id
  def destroy
    if Todo.find_by(id: params[:id])&.destroy
      render json: {}, status: 200
    else
      render json: {}, status: 404
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :priority, :details, :due, :position)
  end
end
