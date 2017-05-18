class CommentsController < ApplicationController
  def create
    @post=Post.find(params[:id])
    @comment=@post.comments.create(params[:comment].permit(:comment))
    @comment.user_id=session[:user_form_id] if session[:user_form_id]
    @comment.save
    redirect_to :controller=>"posts",:action=>"show",:id=>@post.id
  end

  def new
  end

  def edit
    @data=params[:id].split("-")
    @comment=Comment.find(@data[0])
  end

  def delete
    data=params[:id].split("-")
    @comment=Comment.find(data[0])
    @comment.destroy
    redirect_to :controller=>"posts",:action=>"show",:id=>data[1]
  end

  def update_data
    @post=Post.find(params[:post_id])

    @comment=Comment.find(params[:id])
    @comment.update(:comment=>params[:comment][:comment])
    redirect_to :controller=>"posts",:action=>"show",:id=>@post.id

  end

  def index
  end

  def show
  end
end
