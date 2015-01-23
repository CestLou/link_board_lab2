class PostsController < ApplicationController

    def index
        @posts = Post.all
        @votes = Vote.all

    end

    def show
    end

    def new
        @post = Post.new
    end

    def create
      return unless is_authenticated?
      user = User.find_by_id(@current_user['id'])
      @post = user.posts.create post_params
      if @post.errors.any?
        render :new
      else
        flash[:success] = 'Post added'
        redirect_to posts_path
      end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    def comments
      @post = Post.find_by_id(params[:id])
      @comment = Comment.new
    end

    def create_comment
      return unless is_authenticated?
      user = User.find_by_id(@current_user['id'])
      post = Post.find_by_id(params[:id])
      comment = Comment.find_by_id(params[:id])
      user.comments << post.comments.create({body:params[:comment][:body]})
      comment.votes << comment.votes.create!
      redirect_to post_comments_path
      # render json: post
    end



    def create_vote
      user = User.find_by_id(@current_user['id'])
      post = Post.find_by_id(params[:id])
      # vote = Vote.create({body:params[:vote][:body]})
      user.votes << post.votes.create!
      redirect_to posts_path
      # render json: params



      # existing_vote = post.votes.where(:user_id: user.id).any?
      # if existing_vote
      #   flash warning "you already upvotes"
      # else
      #   user.votes << post.votes.create!
      # end

      # respond_to do |format|
      #   format.json { result: !existing_vote }
      #   format.html { redirect_to post_comments_path(parent_post(comment)) }



    end

  private

  def post_params
    params.require(:post).permit(:title,:link)
  end

  def parent_post comment
    return comment if comment.class == Post
    return parent_post(comment.commentable)
  end

end