class NotesController < ApplicationController
  def new
    @note = Note.new
  end


  def create
    @contact = Contact.find(params[:contact_id])
    @project = Project.find(params[:project_id]) unless params[:project_id].nil?
    if params[:project_id].nil?
      @note = @contact.notes.build(note_params)
    else
      @note = @project.notes.build(note_params)
    end
    if @note.save
      redirect_to @project, notice: 'Note created!' if params[:project_id]
      redirect_to @contact, notice: 'Note created!' if params[:project_id].nil?
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
      redirect_to contact_path(@note.contact_id), notice: 'Note updated!' if @note.contact_id
      redirect_to project_path(@note.project_id), notice: 'Note updated!' if @note.project_id

    else
      render 'edit'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to contact_path(@note.contact_id), notice: 'Note deleted!' if @note.contact_id
    redirect_to project_path(@note.project_id), notice: 'Note deleted!' if @note.project_id
  end

  private

  def note_params
    params.require(:note).permit(:subject, :content, :project_id, :contact_id).merge(user_id: current_user.id)
  end
end
