module Rapidfire
  class QuestionsController < ApplicationController
    respond_to :html, :js

    before_filter :find_question_group!
    before_filter :find_question!, :only => [:edit, :update, :destroy]

    def index
      @questions = @question_group.questions
      respond_with(@questions)
    end

    def new
      @question = QuestionProxy.new(:question_group => @question_group)
      respond_with(@question)
    end

    def create
      proxy_params = question_params.merge(:question_group => @question_group)
      @question = QuestionProxy.new(proxy_params)
      @question.save

      respond_with(@question)
    end

    def edit
      @question = QuestionProxy.new(:question => @question)
      respond_with(@question)
    end

    def update
      proxy_params = question_params.merge(:question => @question)
      @question = QuestionProxy.new(proxy_params)
      @question.save

      respond_with(@question)
    end

    def destroy
      @question.destroy

      respond_with(@question)
    end

    private
    def question_params
      params.require(:question).
        permit(:type, :question_text,
               :answer_options, :answer_presence,
               :answer_minimum_length, :answer_maximum_length,
               :answer_greater_than_or_equal_to, :answer_less_than_or_equal_to)
    end

    def find_question_group!
      @question_group = QuestionGroup.find(params[:question_group_id])
    end

    def find_question!
      @question = @question_group.questions.find(params[:id])
    end
  end
end