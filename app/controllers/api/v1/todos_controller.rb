class Api::V1::TodosController < ApplicationController
  def index
    todos = Todo.order(updated: :desc)
    render json: todos
  end

  def show
    todos = Todo.find(params[:id])
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo
    else
      render json: todo.errors, status: 422
    end
  end

  def update
    todos = Todo.find(params[:id])
    if todo.update(todo_params)
      render json: todo
    else
      render json: todo.errors, status: 422
    end
  end

  def destroy
    if Todo.destroy(params[:id])
      head :no_content
    else
      render json: { error: "Failed to destroy" }, status: 422
    end
  end

  def destroy_all
    if Todo.destroy_all
      head :no_content
    else
      render json: { error: "Failed to destroy" }, status: 422
    end
  end

  private
  def todo_params
    params.require(:todo).permit(:name, :is_completed)
  end
end