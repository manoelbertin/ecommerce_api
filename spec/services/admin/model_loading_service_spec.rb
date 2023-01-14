require "rails_helper"

describe Admin::ModelLoadingService do
  context "when #call" do
    let!(:system_requirements) { create_list(:system_requirement, 15) }
    
    context "when params are present" do
      let!(:search_system_requirements) do
        system_requirements = []
        15.times do |n| 
          system_requirements << create(:system_requirement, name: "Search #{n + 1}", video_board: "GeForce")
        end
        system_requirements
      end

      let!(:unexpected_search_system_requirements) do
        system_requirements = []
        15.times do |n| 
          system_requirements << create(:system_requirement, name: "Search #{n + 16}")
        end
        system_requirements
      end

      let(:params) do
        { search: { name: "Search", video_board: "GeFor" }, order: { name: :desc }, page: 2, length: 4 }
      end

      it "performs right :length following pagination" do
        service = described_class.new(SystemRequirement.all, params)
        result_system_requirements = service.call
        expect(service.records.count).to eq 4
      end

      it "does not return unexpected records" do
        params.merge!(page: 1, length: 50)
        service = described_class.new(SystemRequirement.all, params)
        result_system_requirements = service.call
        expect(service.records).to_not include contain_exactly *unexpected_search_system_requirements
      end

      it "returns records following search, order and pagination" do
        search_system_requirements.sort! { |a, b| b[:name] <=> a[:name] }
        service = described_class.new(SystemRequirement.all, params)
        result_system_requirements = service.call
        expected_system_requirements = search_system_requirements[4..7]
        expect(service.records).to contain_exactly *expected_system_requirements
      end
    end

    context "when params are not present" do
      it "returns default :length pagination" do
        service = described_class.new(SystemRequirement.all, nil)
        service.call
        expect(service.records.count).to eq 10
      end

      it "returns first 10 records" do
        service = described_class.new(SystemRequirement.all, nil)
        result_system_requirements = service.call
        expected_system_requirements = system_requirements[0..9]
        expect(result_system_requirements).to contain_exactly *expected_system_requirements
      end
    end
  end
end