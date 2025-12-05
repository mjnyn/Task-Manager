require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validation" do
    context "with present title" do
      let(:task) { build(:task) }
      it "is valid with a title" do
        expect(task).to be_valid
      end
    end

    context "with empty title" do
      let(:task) { build(:task, title: "") }
      it "is not valid" do
        expect(task).to_not be_valid
      end
    end

    context "with nil title" do
      let(:task) { build(:task, title: nil) }
      it "is not valid" do
        expect(task).to_not be_valid
      end
    end
  end
end
