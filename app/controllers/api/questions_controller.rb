class Api::QuestionsController < Api::SharedController

  params_for :question, :text, :activity_id, :user_id

  def index
    @questions = Question.includes(:user, :activity).search(params)
    render json: @questions.as_json(
      include: {
        user: { only: [:id, :full_name] },
        activity: { only: [:id, :name] }
      }
    )
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  def upvote
    @question = Question.find(params[:id])

    if @question.increment!(:votes)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end
end
