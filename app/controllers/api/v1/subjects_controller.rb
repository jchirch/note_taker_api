module Api
  module V1
    class SubjectsController < ApplicationController
      def index
        @subjects = Subject.all
        render json: @subjects
      end
    
      def show
        @subject = Subject.find(params[:id])
        render json: @subject, include: :notes
      end
    
      def create
        @subject = Subject.new(subject_params)
        if @subject.save
          render json: @subject, status: :created
        else
          render json: { errors: @subject.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      private
    
      def subject_params
        params.require(:subject).permit(:name)
      end
    end
  end
end
