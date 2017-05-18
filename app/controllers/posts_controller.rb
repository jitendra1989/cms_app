class PostsController < ApplicationController
 # before_action :authenticate_user!,except:[:index,:show]
  def index
    @data=Post.all.order("created_at Desc")
  end

  def new
   # @post=current_user.posts.build
  end

  def create
 # @article = current_user.posts.build(post_params)
  @article=Post.new(post_params)
  @article.user_id=session[:user_form_id]
  @article.save
  redirect_to :action=>"show",:id=>@article.id
end

  def edit
    @posts=Post.find(params[:id])

  end

  def delete
     @article = Post.find(params[:id])
     @article.destroy
      redirect_to :action=>"index"
  end

  def update_data
     @article = Post.find(params[:id])
     @article.update(post_params)
      redirect_to :action=>"show",:id=>@article.id
  end

  def show
    @article=Post.find(params[:id])
  end

def destroy_session
session[:user_form_id]=nil
flash[:notice] = "Successfully Logged out..."

redirect_to :action=>"index"

end
   def registration_sign_up

  end

  def registration_create

    userdata=User.new(user_forum_params)
    userdata.save
    session[:user_form_id]=userdata.id

redirect_to :controller=>"posts",:action=>"index"
  end

   def registration_sign_in

  end

  def registration_sign_in_create

  user = User.authenticateUsersWithSchool(params[:resource_name][:email], params[:resource_name][:encrypted_password]) 
  if user.present?
    session[:user_form_id]=user.id

    flash[:notice] = "Successfully Logged in..."


redirect_to :controller=>"posts",:action=>"index"
else
  
    flash[:notice] = "Email Id or Password Entered does not match..."

    session[:user_form_id]=""
redirect_to :controller=>"posts",:action=>"index"

  end
  end

  def email_search_data
    email_id=MgEmail.find_by(:mg_email_id=>params[:email])
    if email_id.present?
      data=1
else
data=0

end
  render :json => {:name =>data}

  end


private
  def post_params
    params.require(:posts).permit(:title, :content)
  end
  # def post_params
  #   params.require(:posts).permit(:title, :content)
  # end
  def user_forum_params
      params.require(:resource_name).permit(:email,:encrypted_password)
    end
end
