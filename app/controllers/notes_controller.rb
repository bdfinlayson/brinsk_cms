class NotesController < ApplicationController
  before_action :authenticate_user!

  def new
    @note = Note.new
  end

  def create
    @contact = Contact.find(params[:contact_id])
    @note = @contact.notes.create(note_params)
    if @note.save
      redirect_to @contact, notice: 'Note created!'
    else
      redirect_to root_path
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to contact_path(@note.contact_id), notice: 'Note updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to contact_path(@note.contact_id), notice: 'Note deleted!'
  end

  private

  def note_params
    params.require(:note).permit(:subject, :content)
  end
end
