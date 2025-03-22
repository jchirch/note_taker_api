module Api
  module V1
    class NotesController < ApplicationController
      def index
        if params[:subject_id]
          subject = Subject.find(params[:subject_id])
          @notes = subject.notes
        else
          @notes = Note.all
        end
        render json: @notes
      end
    
      def show
        @note = Note.find(params[:id])
        render json: @note, include: :subjects
      end
    
      def create
        @note = Note.new(note_params)
        if @note.save
          render json: @note, status: :created
        else
          render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @note = Note.find_by(id: params[:id])

        if @note.nil?
          return render json: { errors: "Note not found" }, status: :not_found
        end

        @note.subjects.clear

        if @note.destroy
          render json: {message: 'Note has been deleted' }, status: :ok
        else
          render json: { errors: 'Failure to delete note' }, status: :unprocessable_entity
        end
      end

      def count
        count = Note.count
        render json: {count: count}
      end
    
      private
    
      def note_params
        params.require(:note).permit(:title, :content, subject_ids: [])
      end
    end
    
  end
end
