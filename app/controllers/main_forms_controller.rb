class MainFormsController < ApplicationController
  before_action :find_main_form, only: [:edit, :go_back_to_previous_question, :update, :results]

  def new
    @main_form = MainForm.new(answers: 'a')
    @question = @main_form.next_step
  end

  def create
    @main_form = MainForm.new(main_form_params)
    @main_form.save!
    if @main_form.answers.split('_').last.start_with?('end')
      redirect_to results_path(id: @main_form.id)
    else
      redirect_to edit_main_form_path(@main_form)
    end
  end

  def edit
    @current_question = @main_form.current_question
    @previous_question = @main_form.previous_step
    @question = @main_form.next_step
  end

  def go_back_to_previous_question
    @main_form.back_to_previous_question
    if @main_form.answers.length > 1
      redirect_to edit_main_form_path(@main_form)
    else
      @main_form.delete
      redirect_to new_main_form_path
    end
  end

  def update
    @question = @main_form.current_question.to_sym
    @answer = main_form_params[:answers].split('_')[1].to_sym
    @main_form.answer(@question, @answer)
    @next_step = @main_form.answers.split('_').last.to_sym
    if @next_step.to_s.start_with?('end')
      redirect_to results_path(id: @main_form.id)
    else
      redirect_to edit_main_form_path(@main_form)
    end
  end

  def results
    @end = MainForm::TREE[@main_form.current_question.to_sym]
  end

  private

  def main_form_params
    params.require(:main_form).permit(:answers, :return_to_previous)
  end

  def find_main_form
    @main_form = MainForm.find(params[:id])
  end
end
