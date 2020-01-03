class CommentsController < ApplicationController
    before_action :set_event
    before_action :set_event_comment, only: [:show, :update, :destroy]

    #GET /events/:event_id/comments
    def index
        json_response(@event.comments)
    end

    #GET /events/:event_id/comments/:id
    def show
        json_response(@comment)
    end

    #POST /events/:event_id/comments
    def create
        @event.comments.create!(comment_params)
        json_response(@event, :created)
    end

    #PUT /events/:event_id/comments/:id
    def update
        @comment.update(comment_params)
        head :no_content
    end

    #DELETE /events/:event_id/comment/:id
    def destroy
        @comment.destroy
        head :no_content
    end

    private

    def comment_params
        params.permit(:user_id, :text)
    end

    def set_event
        @event = Event.find(params[:event_id])
    end

    def set_event_comment
        @comment = @event.comments.find_by!(id: params[:id]) if @event
    end
end
