class MainFormsController < ApplicationController

  def new
    @main_form = MainForm.new
    @question = @main_form.next_step
  end

  def create
    @main_form = MainForm.new(main_form_params)
    @main_form.save!
    redirect_to edit_main_form_path(@main_form)
  end

  def edit
    @main_form = MainForm.find(params[:id])
    @current_question = @main_form.current_question
    @question = @main_form.next_step
  end

  def update
    @main_form = MainForm.find(params[:id])
    @question = @main_form.current_question.to_sym
    @answer = main_form_params[:answers].split('_')[1].to_sym
    @next_step = main_form_params[:answers].split('_').last.to_sym
    @main_form.answer(@question, @answer)
    puts "\n \n \n \n "
    puts "A la question : #{@question} (#{@question.class})"
    puts "Vous avez répondu : #{@answer} (#{@answer.class})"
    puts "Qui mène à l'etape : #{@next_step} (#{@next_step.class})"
    puts "Object : #{@main_form.answers}"
    puts "\n \n \n \n "
    if @next_step.to_s.start_with?('end')
      redirect_to results_path(id: @main_form.id)
    else
      redirect_to edit_main_form_path(@main_form)
    end
  end

  def results
    @main_form = MainForm.find(params[:id])
    @end = MainForm::TREE[@main_form.current_question.to_sym]
  end

  private

  def main_form_params
    params.require(:main_form).permit(:answers)
  end
end
