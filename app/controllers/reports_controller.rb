class ReportsController < ApplicationController
    before_action :set_comment

    #POST /report
    def create
        @comment.reports.create!(report_params)
        json_response(@comment.reports.last, :created)
    end

    private

    def report_params
        params.permit(:user_id, :comment_id)
    end

    def set_comment
        @comment = Comment.find(params[:comment_id])
    end
end
