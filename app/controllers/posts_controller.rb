class PostsController < AuthorizedController
  before_action :set_post, only: %i[show edit update destroy]
  # before_action :authenticate_user!
  
  
  def index
    @organization = Organization.find_by(id: params[:organization_id])
    @posts = @organization.posts 
  end

  def show
    @organization = Organization.find(params[:organization_id])
  end

  def new
    @organization = Organization.find_by(id: params[:organization_id])
    @post = @organization.posts.new 
  end

  def edit
    @organization = Organization.find_by(id: params[:organization_id])
  end

  def create
    @organization = Organization.find_by(id: params[:organization_id])
    @post = @organization.posts.new(post_params)
    @post.user = current_user  
      if @post.save
      redirect_to organization_posts_path, notice: "Post was successfully created."
      else
        render :new
      end
  end

  def update
      if @post.update(post_params)
       redirect_to organization_posts_url, notice: "Post was successfully updated." 
      else
        render :edit
      end
  end

  def destroy
    @post.destroy!
    redirect_to organization_posts_path(@post.organization), notice: "Post was successfully destroyed." 
  end

  private

  def set_post
    @post = Post.find(params[:id]) 
  end

  def post_params
    params.require(:post).permit(:title, :body, :organization_id)
  end
end
