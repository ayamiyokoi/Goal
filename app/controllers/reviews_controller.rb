# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :set_review_all, only: %i[ index topics ]
  before_action :set_review_mine, only: %i[ index topics ]
  before_action :set_review_liked, only: %i[ topics ]
  before_action :set_review_know, only: %i[ index topics ]
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
  end

  def topics
    #TODO: どこにincludeつける?
    #TODO: メソッドにして
    #TODO: activeの更新ができてない
    # @reviews_like = Kaminari.paginate_array(Review.sorted_by_likes).page(params[:page]).per(10)
    @reviews_like = Kaminari.paginate_array(Review.where(user_id: current_user.friends.pluck(:id), active: true).or(Review.where(user_id: User.where(show_status: 2).pluck(:id), active: true)).sorted_by_likes).page(params[:page]).per(10)
    #@reviews_like = Kaminari.paginate_array(Review.joins(:user).select("reviews.*, user.*").where(show_status: 2).sorted_by_likes).page(params[:page]).per(10)
    # @reviews_like = Review.sorted_by_likes
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @comment = Comment.new
    @comments = @review.comments.order(created_at: :desc)
    @user = User.find(@review.user_id)
    unless @review == nil
      # %表示
      @rate = {"達成" => @review.rate, "未達成" => 100-@review.rate}
    end
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    review = Review.where(user_id: current_user.id, created_at: Time.current.at_beginning_of_day..Time.current.at_end_of_day)
    if review.exists?
      review.update(review_params)
      format.html { redirect_to @review, notice: "振り返りの更新に成功しました。" }
      format.json { render :show, status: :ok, location: @review }
    else

    @review = Review.new(review_params)
    @review.user_id = current_user.id
    respond_to do |format|
      if @review.save
        # 目標達成で5pt, タスク達成で2pt, 振り返り投稿で1pt、自分のレベルの3乗倍のポイントがたまるとレベルアップ
        #TODO: めそっどにして
        if 5*Goal.where(user_id: current_user.id, achieved: true).count + 2*Task.where(user_id: current_user.id, finished: true).count + Review.where(user_id: current_user.id).count > 3**current_user.level
          current_user.level = current_user.level + 1
          current_user.save
          flash[:notice] = "レベル「＋１」アップ 、現在のレベルは#{current_user.level}です。"
        end
        format.html { redirect_to @review, notice: "振り返りの作成に成功しました。" }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: "振り返りの更新に成功しました。" }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "振り返りを削除しました。" }
      format.json { head :no_content }
    end
  end


  private

    def set_review_all
      @reviews_all = Review.where(user_id: User.where(show_status: 2).pluck(:id)).page(params[:page]).per(10)
    #   @reviews_all = User.where(show_status: 2).page(params[:page]).per(10)
    end

    def set_review_mine
      @reviews_mine = Review.where(user_id: current_user.id).page(params[:page]).per(10)
    end

    def set_review_liked
      @reviews_liked = current_user.liked_reviews.page(params[:page]).per(10)
    end

    def set_review_know
      # @reviews_know = current_user.friends.page(params[:page]).per(10)
      #N+1問題対策
      @reviews_know = Review.where(user_id: current_user.friends.pluck(:id)).includes([:user]).page(params[:page]).per(10)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.joins(:user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit( :rate, :review, :plan, :title, :topic)
    end
end
