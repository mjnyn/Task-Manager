require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    it "returns success response" do
      get tasks_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /tasks" do
    context "with present title" do
      let(:valid_params) { { task: attributes_for(:task, title: "Test Task") } }
      it "creates a task" do
        expect {
          post tasks_path, params: valid_params
      }.to change(Task, :count).by(1)
      end
    end

    context "with empty title" do
      let(:invalid_params) { { task: attributes_for(:task, title: "") } }
      it "does not create a task" do
        expect {
          post tasks_path, params: invalid_params
      }.to_not change(Task, :count)
      end
    end

    context "with nil title" do
      let(:invalid_params) { { task: attributes_for(:task, title: nil) } }
      it "does not create a task" do
        expect {
          post tasks_path, params: invalid_params
      }.to_not change(Task, :count)
      end
    end
  end
end
