module Admin::Controllers::Tasks
  class Update
    include Admin::Action
    include Import['core.markdown']
    expose :task

    params do
      required(:id).filled
      required(:task).schema do
        required(:title).filled(:str?)
        required(:md_body).filled(:str?)
        required(:approved).filled
        required(:lang).filled
        required(:status).filled
        required(:complexity).filled
        required(:time_estimate).filled
        optional(:issue_url).maybe(:str?)
        optional(:repository_name).maybe(:str?)
        optional(:assignee_username).maybe(:str?)
      end
    end

    def call(params)
      @task = repo.find(params[:id])

      # TODO: To operation
      if @task && params.valid?
        task_params = params[:task]
        task_params[:body] = markdown.parse(task_params[:md_body])

        repo.update(@task.id, task_params)
        redirect_to routes.task_path(task.id)
      else
        self.status = 422
      end
    end

  private

    def repo
      @repo ||= TaskRepository.new
    end
  end
end
