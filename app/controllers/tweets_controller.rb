class TweetsController < ApplicationController
  def index
    # 投稿を新着順＆ページング
    @tweets = Tweet.all.order("id ASC").page(params[:page]).reverse_order
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    # binding.pry
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = "Good Job!　投稿完了です！"
      redirect_to complete_tweets_path
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    # binding.pry
    if @tweet.update(tweet_params)
      flash[:notice] = "Good Job! 内容を変更しました"
      redirect_to tweet_path(@tweet)
    else
      flash[:alert] = "投稿の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to user_path(current_user)
  end

  def complete
  end

  private

  def tweet_params
    params.require(:tweet).permit(:time, :tweet, :challenge,
                                  :hour_attribute, :minute_attribute, images: [])
  end
end
