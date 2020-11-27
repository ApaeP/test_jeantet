class MainFormsController < ApplicationController

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
    # Fetching the form from params
    if params[:id].nil?
      @main_form = MainForm.new(answers: 'a')
    else
      @main_form = MainForm.find(params[:id])
    end
    # Determine the current asked question from the form
    @current_question = @main_form.current_question
    puts "\n \n \n \n "
    p @current_question
    puts "\n \n \n \n "
    @question = @main_form.next_step
  end

  def update
    # Fetching the form from params
    @main_form = MainForm.find(params[:id])
    # fetching the answered question from the form
    @question = @main_form.current_question.to_sym
    # fetching the answer from params
    @answer = main_form_params[:answers].split('_')[1].to_sym
    # store the answer in the form model
    puts "\n \n \n \n "
    puts "pour l'objet: #{@main_form.answers}"
    puts "A la question : #{@question} (#{@question.class})"
    puts "Vous avez répondu : #{@answer} (#{@answer.class})"
    puts "Qui mène à l'etape : #{@main_form.answers.split('_').last.to_sym} (#{@main_form.answers.split('_').last.to_sym.class})"
    @main_form.answer(@question, @answer)
    puts "Object : #{@main_form.answers}"
    puts "\n \n \n \n "
    # determine what is the next step's key in the TREE from
    @next_step = @main_form.answers.split('_').last.to_sym
    # determine if the next step is a conclusion or a question
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
