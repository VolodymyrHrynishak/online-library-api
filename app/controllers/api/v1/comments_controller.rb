module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[show update destroy]

      # GET /comments
      def index
        @comments = Comment.all
        render json: @comments
      end

      # GET /comments/1
      def show
        render json: @comment
      end

      # POST /comments
      def create
        @comment = Comment.new(comment_params)

        if @comment.save
          render json: @comment, status: :created # без location
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /comments/1
      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /comments/1
      def destroy
        @comment.destroy!
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:content, :user_id, :book_id)
      end
    end
  end
end
